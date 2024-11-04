 function  [SamplsFea,XSmpgnd,gndSmpNum]=CreatSampleDatasets(fea,KClass,gnd,nClass,LabelsRatio)
Tags=tabulate(gnd);
SmpNumPerClass=Tags(:,2);
Per=cumsum(SmpNumPerClass);

Kmix=randperm(nClass); 
Klei=Kmix(1:KClass);  

TempFea=[];
TempOrders=[];
TempLabelsOrders=[];
for i=1:KClass
    if Klei(i)==1
        SmpNumPerClassOrders=1:Per(Klei(i));
     
        TempOrders=cat(2,TempOrders,SmpNumPerClassOrders);
         NumP=ceil(SmpNumPerClass(Klei(i))*LabelsRatio);
        Orders=randperm(length(SmpNumPerClassOrders));
        TempLabelsOrders=[TempLabelsOrders,SmpNumPerClassOrders(Orders(1:NumP))];
    else
     
        SmpNumPerClassOrders=Per(Klei(i)-1)+1:Per(Klei(i));
        TempOrders=cat(2,TempOrders,SmpNumPerClassOrders);

         NumP=ceil(SmpNumPerClass(Klei(i))*LabelsRatio); 
         Orders=randperm(length(SmpNumPerClassOrders));
         TempLabelsOrders=[TempLabelsOrders,SmpNumPerClassOrders(Orders(1:NumP))];
       
    end
  
end
gndSmpNum=length(TempLabelsOrders);
SampleOrders=[TempLabelsOrders,setdiff(TempOrders,TempLabelsOrders)];
SamplsFea=fea(SampleOrders,:);

SamplsGnd=gnd(SampleOrders);


Temp=SamplsGnd;
for i=1:KClass
    SamplsGnd(Temp==Klei(i))=i;
end
XSmpgnd=SamplsGnd;

 end
 
