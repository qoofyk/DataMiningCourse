function[model,c_max,val]=tuneC(model,interval,up,Y,X,s)
j=1;
%s=5;
for i=0.01:interval:up
    str=['-s ' num2str(s) ' -c ' num2str(i) ' -v 5'];
    model(1,j) =  train(Y,sparse(X),str);
    j=j+1;
end
[val,ind]=max(model);
c_max=0.01+interval*(ind-1);
end