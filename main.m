clear all 
clc
 load('COIL100_Obj.mat');	% Load feature matrix (fea) and labels (gnd)
 nClass = length(unique(gnd));
 dataset='COIL100_Obj';      
 fea=double(fea);
 
 %Sort samples by labels
 [labels,index]=sort(gnd,'ascend');
 gnd=labels;
 fea=fea(index,:);
 fea=double(fea);
 
 %Unit Euclidean length normalization
 fea = NormalizeFea(fea);  % Normalize in Euclidean length

 LabelsRatio=0.1; % labeled, semi-supervised setting
 K=nClass; % Number of clusters = number of ground truth classes
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
      % Randomly select sample subset for training
     [X,Smpgnd,count]=CreatSampleDatasets(fea,K,gnd,nClass,LabelsRatio);
     % X:selected data points belong to K Classes
     % Smpgnd: the lables of selected data points
     % count: the number of selected data points
     % Configure algorithm parameters
     Options.maxIter=200;
     Options.gndSmpNum=count;
     Options.Smpgnd=Smpgnd;
     Options.KClass=K;
     Options.nClass=nClass;
      % -------------------------------------------
     %  Run LCNMF
     % -------------------------------------------
     [~,V,~]=LCNMF(X',Options);
     [~, label] = max(V');
     newL=bestMap(Smpgnd,label);
     AC=Accuracy(newL,Smpgnd);
     MIhat = MutualInfo(Smpgnd,label);  
     TempAC(h)=AC;% accuracy.acc;
     TempMI(h)=MIhat;% accuracy.nmi;
     % -------------------------------------------
     %  Run LCNMF-div
     % -------------------------------------------
     [~,V,~]=LCNMFdiv(X',Options);
     [~, label] = max(V');
     newL=bestMap(Smpgnd,label);
     AC=Accuracy(newL,Smpgnd);
     MIhat = MutualInfo(Smpgnd,label);  
     TempACdiv(h)=AC;% accuracy.acc;
     TempMIdiv(h)=MIhat;% accuracy.nmi
     
     
     
 end
 % Final averaged performance over 20 runs
    meanAC=mean(TempAC);
    meanMI=mean(TempMI);
    meanACdiv=mean(TempACdiv);
    meanMIdiv=mean(TempMIdiv);
%     stdAC=std(TempAC);
%     stdMI=std(TempMI);

 
 
    

 
