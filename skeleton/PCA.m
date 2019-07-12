%Function: PCA Project data from high dimension feature to low dimension feature

%input: Original feature 

%output: Projected feature % Projected Eigenvalue and Eigenvector


function  [e_feat,PCA_ALLFEAT] = PCA(ALLFEAT) 

[x , y] = size(ALLFEAT');
e_feat = Eigen_Build(ALLFEAT');

sum_e_eigenvalue = 0;

for count = 1 : x
    sum_e_eigenvalue = sum_e_eigenvalue + e_feat.val(count);
    if sum_e_eigenvalue >= 0.95*sum(e_feat.val)
        break
    end
end

e_feat = Eigen_Deflate(e_feat,'keepn',count);
PCA_ALLFEAT = Eigen_Project(ALLFEAT',e_feat);
PCA_ALLFEAT = PCA_ALLFEAT';

    







