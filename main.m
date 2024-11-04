clear all 
clc
 load('COIL100_Obj.mat');	
 nClass = length(unique(gnd));
 dataset='COIL100_Obj';      
 fea=double(fea);
 
 %Sort samples by labels
 [labels,index]=sort(gnd,'ascend');
 gnd=labels;
 fea=fea(index,:);
 fea=double(fea);
 
 %Unit Euclidean length normalization
 fea = NormalizeFea(fea); 

 LabelsRatio=0.1;
 K=nClass; %full-size dataset as input data  
 meanAC=[];
 meanMI=[];
 meanACdiv=[];
 meanMIdiv=[];
%  stdAC=[];
%  stdMI=[];
  TempAC=[];
  TempMI=[];
  TempACdiv=[];
  TempMIdiv=[];
  for h=1:20
     %Select the data points of K classes as the input of the algorithm
     [X,Smpgnd,count]=CreatSampleDatasets(fea,K,gnd,nClass,LabelsRatio);
     % X:selected data points belong to K Classes
     % Smpgnd: the lables of selected data points
     % count: the number of selected data points
     Options.maxIter=200;
     Options.gndSmpNum=count;
     Options.Smpgnd=Smpgnd;
     Options.KClass=K;
     Options.nClass=nClass;
     %LCNMF
     [~,V,~]=LCNMF(X',Options);
     [~, label] = max(V');
     newL=bestMap(Smpgnd,label);
     AC=Accuracy(newL,Smpgnd);
     MIhat = MutualInfo(Smpgnd,label);  
     TempAC(h)=AC;% accuracy.acc;
     TempMI(h)=MIhat;% accuracy.nmi;
     %LCNMF-div
     [~,V,~]=LCNMFdiv(X',Options);
     [~, label] = max(V');
     newL=bestMap(Smpgnd,label);
     AC=Accuracy(newL,Smpgnd);
     MIhat = MutualInfo(Smpgnd,label);  
     TempACdiv(h)=AC;% accuracy.acc;
     TempMIdiv(h)=MIhat;% accuracy.nmi
     
     
     
 end
    meanAC=mean(TempAC);
    meanMI=mean(TempMI);
    meanACdiv=mean(TempACdiv);
    meanMIdiv=mean(TempMIdiv);
%     stdAC=std(TempAC);
%     stdMI=std(TempMI);

 
 
    
 