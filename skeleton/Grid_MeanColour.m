%Function: break down img to M*M cells

%Input: img and number of cells

%Output: 

function  F = Grid_MeanColour(img , M)


[img_h,img_w, ~] = size(img);
grid_h = floor(img_h / M);
grid_w = floor(img_w / M);

F2=zeros(M,M,3);

for i =1 : M
    for j = 1 : M
        
        cell = img((i-1)*grid_h+1 : i*grid_h , (j-1)*grid_w+1 : j*grid_w ,:);
        colour =  [mean(reshape (cell(:,:,1),1,[])); mean(reshape (cell(:,:,2),1,[])); mean(reshape (cell(:,:,3),1,[])) ];
        %imshow(cell)

     F2(i,j,:)= colour;
   
     F1= [(reshape (F2(:,:,1),1,[]));(reshape (F2(:,:,2),1,[])); (reshape (F2(:,:,3),1,[])) ];  %3 * (M*M)
     F =  reshape (F1,1,[]); % 1* (M*M*3)
    
    
       
    end
end

