function H=GlobalColourHistogram(img,Q) % image,quantization


qimg = floor(img.*Q);

bin = qimg(:,:,1)*Q^2+qimg(:,:,2)*Q+qimg(:,:,3);

vals = reshape(bin,1,size(bin,1)*size(bin,2));

vals_sort = sort(vals);
bin_c =zeros(1,Q^3);
count = 0;

for i = 1 :1 : size(bin,1)*size(bin,2)
    if  i==1 
        count = count + 1;
      
    elseif i>=2 && vals_sort(i) == vals_sort(i-1)
            count = count + 1;
     
    elseif i>=2 && vals_sort(i) ~= vals_sort(i-1)
               bin_c(vals_sort(i-1)+1) = count;
              count = 1;        
    end
end
bin_c(vals_sort(size(bin,1)*size(bin,2))+1) = count; %the biggest value

H=bin_c./sum(bin_c);
% qimg = im2double(img);
% qimg = floor(qimg.*Q);
% 
% bin = qimg(:,:,1)*Q^2+qimg(:,:,2)*Q+qimg(:,:,3);
% 
% vals = reshape(bin,1,size(bin,1)*size(bin,2));



%H=hist(vals,Q^3);

%H = H./sum(H);


