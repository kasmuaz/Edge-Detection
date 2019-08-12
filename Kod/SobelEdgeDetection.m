function [image] = SobelEdgeDetection(img,T)
image_dims = ndims(img); 
 if  image_dims == 3
        img = rgb2gray(img);
 end
 
[height, width] = size(img);
mag=zeros(height,width);

Gx=[-1 0 1; -2 0 2; -1 0 1];
Gy=[-1 -2 -1; 0 0 0; 1 2 1];
    for i= 1:(height-2)
        for j = 1:(width-2)
        S1=sum(sum(Gx.*double(img(i:i+2,j:j+2))));
		S2=sum(sum(Gy.*double(img(i:i+2,j:j+2)))); 
        mag(i+1,j+1)=sqrt(S1.^2+S2.^2);
        end
    end
D = mag > T;
image = bwmorph(D,'skel',Inf);
%figure,imshow(image); title('Sobel Edge Detector');   
end
