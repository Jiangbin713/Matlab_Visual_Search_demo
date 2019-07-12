function  F = Grid_EdgeOrientationHistogram(img , M, Edge_quantization)

x_sobel = [1 2 1; 0 0 0; -1 -2 -1]./4; % edge detector
y_sobel = x_sobel';

[img_h,img_w, ~] = size(img);
grid_h = floor(img_h / M);
grid_w = floor(img_w / M);
%Edge_quantization=8;
s = 1; % count sets
H_total = zeros(1,M*M*Edge_quantization); % bin collector
for i =1 : M
    for j = 1 : M
        
         cell = img((i-1)*grid_h+1 : i*grid_h , (j-1)*grid_w+1 : j*grid_w ,:);%grid
         cell_grey = cell(:,:,1)*0.3+cell(:,:,2)*0.59+cell(:,:,3)*0.11; %greyscale
         x_cell = conv2(cell_grey,x_sobel,'same');
         y_cell = conv2(cell_grey,y_sobel,'same');
         %gm_img = sqrt(x_cell.^2+y_cell.^2); %gradient magtitude 
         theta = atan(y_cell./x_cell)+pi/2;
         theta = floor((theta./pi).*(Edge_quantization-2));  % quantize orientation
         %q_gm_img = floor(gm_img.*(Edge_quantization-1));  % quantize orientation 
          
          find_nan = isnan(theta);
          find_nan_sub = find(find_nan);
          size_nan = size(find_nan_sub);
          for x = 1:size_nan
              theta(find_nan_sub(x))=Edge_quantization-1;
          end
          
         vals = reshape(theta, 1, size(theta,1)*size(theta,2));
         count=1;
         vals_sort = sort(vals);
         vals_c=zeros(1,Edge_quantization);
         
         for k=1:1:size(theta,1)*size(theta,2)    % build orientation bins
             if k==1
             count = count+1;
             elseif k>=2 && vals_sort(k)==vals_sort(k-1)
             count = count+1;
             elseif k>=2 && vals_sort(k)~=vals_sort(k-1)
             vals_c(vals_sort(k-1)+1) = count;
             count =1;
             end
        end
vals_c(vals_sort(size(theta,1)*size(theta,2))+1) = count; % the biggest value
H=vals_c./sum(vals_c);
H_total(s:s+Edge_quantization-1)= H;
s = s+Edge_quantization;
   end
end
F = H_total;
% x_sobel = [1 2 1; 0 0 0; -1 -2 -1]./4; % edge detector
% y_sobel = x_sobel';
% 
% [img_h,img_w, ~] = size(img);
% grid_h = floor(img_h / M);
% grid_w = floor(img_w / M);
% %Edge_quantization=8;
% s = 1; % count sets
% H_total = zeros(1,M*M*Edge_quantization); % bin collector
% for i =1 : M
%     for j = 1 : M
%         
%          cell = img((i-1)*grid_h+1 : i*grid_h , (j-1)*grid_w+1 : j*grid_w ,:);%grid
%          cell_grey = cell(:,:,1)*0.3+cell(:,:,2)*0.59+cell(:,:,3)*0.11; %greyscale
%          x_cell = conv2(cell_grey,x_sobel,'same');
%          y_cell = conv2(cell_grey,y_sobel,'same');
%          gm_img = sqrt(x_cell.^2+y_cell.^2); %gradient magtitude 
%          q_gm_img = floor(gm_img.*(Edge_quantization-1));  % quantize orientation 
%          vals = reshape(q_gm_img, 1, size(q_gm_img,1)*size(q_gm_img,2));
%          count=1;
%          vals_sort = sort(vals);
%          vals_c=zeros(1,Edge_quantization);
%          
%          for k=1:1:size(q_gm_img,1)*size(q_gm_img,2)    % build orientation bins
%              if k==1
%              count = count+1;
%              elseif k>=2 && vals_sort(k)==vals_sort(k-1)
%              count = count+1;
%              elseif k>=2 && vals_sort(k)~=vals_sort(k-1)
%              vals_c(vals_sort(k-1)+1) = count;
%              count =1;
%              end
%         end
% vals_c(vals_sort(size(q_gm_img,1)*size(q_gm_img,2))+1) = count; % the biggest value
% H=vals_c./sum(vals_c);
% H_total(s:s+Edge_quantization-1)= H;
% s = s+Edge_quantization;
%    end
% end
% F = H_total;
%     
 











% function H=EdgeOrientationHistogram(img)
% 
% img_grey = img(:,:,1)*0.3+img(:,:,2)*0.59+img(:,:,3)*0.11;  %greyscale
% 
% x_sobel = [1 2 1; 0 0 0; -1 -2 -1]./4; % edge detector
% y_sobel = x_sobel';
% x_img = conv2(img_grey,x_sobel,'same');
% y_img = conv2(img_grey,y_sobel,'same');
% gm_img = sqrt(x_img.^2+y_img.^2); %gradient magtitude 
% 
% qimg = floor(gm_img.*7); 
% 
% vals = reshape(qimg, 1, size(qimg,1)*size(qimg,2));
% count=1;
% vals_sort = sort(vals);
% vals_c=zeros(1,8);
% for i=1:1:size(qimg,1)*size(qimg,2)
%     if i==1
%         count = count+1;
%     elseif i>=2 && vals_sort(i)==vals_sort(i-1)
%         count = count+1;
%     elseif i>=2 && vals_sort(i)~=vals_sort(i-1)
%         vals_c(vals_sort(i-1)+1) = count;
%         count =1;
%     end
% end
% vals_c(vals_sort(size(qimg,1)*size(qimg,2))+1) = count; % the biggest value
% H=vals_c./sum(vals_c);
