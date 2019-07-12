% Plot the PR_Curve
function [R,P] = PR_Curve(e1,e2) %allfiles,dst

pcimgname =cell([1 591]);
pcimgname(1) = cellstr(e1(e2(1,2)).name); % queryimg file name

 % different classes have different number of samples
 switch pcimgname{1}(1:2)   
     case '10'
         c = 32;
     case '12'
         c = 34;
     case '15'
         c = 24;
     case '20'
         c = 21;
     otherwise
         c = 30;
 end
 

 %get the files' name to compare
 k = 2; 
for k=2:1:591
    
    pcimgname(k) = cellstr(e1(e2(k,2)).name);
    k=k+1;

end

%compare and compute precision and recall value for PR Curve
p = 0;
for k=2:1:591
    
    if pcimgname{1}(1:2)==pcimgname{k}(1:2)
    p=p+1;
    end
        
P(k)=p/(k-1); %Precision
R(k)=p/(c-1);%Recall
end        
%E = pcimgname(:);
%save PR_data.mat 
R = R(:);
P = P(:);


% compare and compute Precision of top 20 output results
p=0;
for k=2:1:20
    
    if pcimgname{1}(1:2)==pcimgname{k}(1:2)
    p=p+1;
    end
    
PP(k)=p/19;%Precision
end        
fprintf('Relevant returned images of the top 19 output results: %3.2f %%\n', PP(end)*100);


