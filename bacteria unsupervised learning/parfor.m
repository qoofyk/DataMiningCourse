A=rand(100,100);
B=rand(100,100);
C={};
parfor i=1:10
    for j=1:10
        C{i,j}=A.*B;
    end
end

parfor i = 1:length(A)
   B(i) = sqrt(A(i));
end