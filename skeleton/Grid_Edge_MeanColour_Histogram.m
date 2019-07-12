function F = Grid_Edge_MeanColour_Histogram(F1,F2,M) % Grid & Edge orientation Descriptor
% F1: M*M*3  F2: M*M*A
F = zeros(1,M*M*11);

for i = 1 : 1: M*M 
    F = [F1,F2];
%     F(i*11-10:i*11-8) = F1(3*i-2:3*i);
%     F(i*11-7:i*11)= F2(8*i-7:8*i);
end
