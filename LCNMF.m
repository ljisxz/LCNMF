function  [U,V,obj]=LCNMF(X,Options)
  
 %..............................................
        [M, N]= size(X);

%........................................................
        Y=zeros(Options.gndSmpNum, Options.KClass);
        for i =1:Options.gndSmpNum
              Y(i,Options.Smpgnd(i)) = 1;
          
        end
      
        U = rand(M, Options.KClass);
        V = rand(N, Options.KClass);
         obj=[];
       for iters = 1:Options.maxIter
          V(1:Options.gndSmpNum,:)=V(1:Options.gndSmpNum,:).*Y;
          U =U.*(X*V)./(U*V'*V+eps);
          V =V.*((X'*U)./(V*U'*U+eps));%  
           obj(iters)=sum(sum(( X-U*V').^2)); 
        end

end
       
    