function [NSelLoc,count] = SelLabSam_Semi_2(gnd, Per)
%  randomly	Select Per% samples from each class for semi-supervised NMF methods 
% but do not move the selected sample in the front
% where
% NSelLoc ... the location of all selected samples
% gnd ... the label information N*1
% Per ... the percent that select from each class
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%[N,M] = size(fea);
Nclass = length(unique(gnd));
NLabel = zeros(1,Nclass);
 
for i=1:Nclass
    LocCla = find(gnd==i);           % obtain the location for class i.
    NLabel(i) = round(Per*length(LocCla));
end
NSelLoc = zeros(1, sum(NLabel));    % obtain the location of all labeled sample
count = 0;
for i=1:Nclass
    LocCla = find(gnd==i);          % obtain the location for class i.
    SelLab = randperm(length(LocCla),NLabel(i));
    NSelLoc(count+1:count+NLabel(i)) = LocCla(SelLab);
    count = count + NLabel(i); 
end
if sum(NLabel) ~= length(NSelLoc)
    error('Error!');
end
end