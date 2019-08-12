function image = LoGEdgeDetection(img,sigma,T)

image_dims = ndims(img); 
 if  image_dims == 3
        img = rgb2gray(img);
 end

kernel = -1 * ones(3);
kernel(2,2) = 8;  % Now kernel = [-1,-1,-1; -1,8,-1; -1,-1,-1]
I = GaussFiltering(img,sigma);
image = conv2(double(I), kernel, 'same');

image = image > T;
image = bwmorph(image,'skel',Inf);
end

function image = GaussFiltering(img,sigma)

kernel = zeros(5,5);
W = 0;

for i = 1:5
    for j = 1:5
    sq_dist = (i-3)*(i-3) + (j-3)*(j-3);
    kernel(i,j) = exp((-1*sq_dist)/(2*sigma*sigma));
    W = W + kernel(i,j);
    end
end
kernel = kernel/W;

[m,n] = size(img);
output = zeros(m,n);

Im = padarray(img,[2 2]);
for i = 1:m
    for j = 1:n
    temp = Im(i:i+4,j:j+4);
    temp = double(temp);
    conv = temp .* kernel;
    output(i,j) = sum(conv(:));
    end
end
image = uint8(output);
end