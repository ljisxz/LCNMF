function  [U,V,obj]=LCNMFdiv(X,Options)
  
 %..............................................
        [M, N]= size(X);

%........................................................
        Y=zeros(Options.gndSmpNum, Options.KClass);
        for i =1:Options.gndSmpNum
              Y(i,Options.Smpgnd(i)) = 1;
          
        end
      
        U = rand(M, Options.KClass);
        V = rand(N, Options.KClass);
        
 
        ONES = ones(M,N);
        
         obj=[];
       for iters = 1:Options.maxIter
        V(1:Options.gndSmpNum,:)=V(1:Options.gndSmpNum,:).*Y;
        
         U = U .* ((X./(U*V'+eps))*V) ./(ONES*V);
         V= V .* (U'*( X./(U*V'+eps)))' ./ (U'*ONES)';
         Vhat=U*V';
        Vhat = Vhat + (Vhat<eps) .* eps;
        
        temp = X.*log(X./Vhat);
        temp(temp ~= temp) = 0; % NaN ~= NaN
        obj(iters ) = sum(sum(temp - X + Vhat)); 
         
         
         
      
        end

end
       
    