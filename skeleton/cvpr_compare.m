function dst=cvpr_compare(F1, F2 , Eigenvalue)

% This function should compare F1 to F2 - i.e. compute the distance
% between the two descriptors

%% L1 norm
% x = F1 - F2;
% x = sum(x);
% dst = abs(x);


%% L2 norm
x =F1 - F2;
x = x.^2;
x = sum(x);
dst=sqrt(x);

%% Chebyshev distance
%dst = max(abs(F1-F2));

%% Mahalanobis distance
% dst = sqrt(sum(((F1-F2).^2)./Eigenvalue , 2));
end
