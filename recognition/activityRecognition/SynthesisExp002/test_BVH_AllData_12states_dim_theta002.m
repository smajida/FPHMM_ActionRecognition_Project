%This is experiment script to test the convergence of thetas

close all
clear all
clc

ExperimentName = 'SynthesisExp002';
path0 = getenv('FPHMM_PATH')
addpath(genpath(strcat(path0,'fullyParameterizedHMM/Project/recognition/activityRecognition')));
addpath(genpath(strcat(path0,'fullyParameterizedHMM/ContextualModel')));
addpath(genpath(strcat(path0,'fullyParameterizedHMM/Project/recognition')));
addpath(genpath(strcat(path0,'fullyParameterizedHMM/Project')))
addpath(genpath(strcat(path0,'fullyParameterizedHMM/Project/recognition/activityRecognition/Classifiers/data001/')));
addpath(genpath(strcat(path0,'fullyParameterizedHMM/HMMall/HMM')));
addpath(genpath(strcat(path0,'fullyParameterizedHMM/HMMall/KPMstats')));
addpath(genpath(strcat(path0,'fullyParameterizedHMM/HMMall/KPMtools')));
addpath(genpath(strcat(path0,'fullyParameterizedHMM/HMMall/netlab3.3')));

addpath(genpath(strcat(path0,'fullyParameterizedHMM/Project/recognition/activityRecognition/Experiments')));
addpath(genpath(strcat(path0,'fullyParameterizedHMM/Project/recognition/activityRecognition/',ExperimentName)));

isPrepareData = 1;% 1 prepare data; 0:load old data
left2rightHMMtopology = 0;
numStates = 12;%8
numMix = 1;
mxIter_FPHMM = 35;%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
FPHMM_HMM_init_Iter = 25;  %!!!!!!!!!!!!!!!!!!!!!!!!!!
isNormalized = 0;
isRandomInit = 1;
emotionCell = {'Anger','Anxiety','Joy','Neutral','Panic Fear','Pride','Sadness','Shame'};
activityCell = {'Being Seated','Sitting Down','Knocking on the Door','Lift','Move Books','Simple Walk','Throw','Walk with smth in the Hands'};
MissingPairs = {'Anger','Simple Walk';'Joy','Knocking on the Door';'Sadness','Move Books'};
%Names = {'Brian','Elie','Florian','Hu'};
Names = {'Brian','Elie','Florian','Hu','Janina','Jessica','Maria','Muriel','Robert','Sally','Samih','Tatiana'}
TestProportion = 0.3;
TrainingProportion = 0.7;

isPCA = 1;
if isPrepareData ==0
	prepareData_Train_Val_Test;
end
TestProportion = 0.3;
TrainingPropotion = 0.7;

numEmotion = size(emotionCell,2);
numActivity = size(activityCell,2);
numActor = size(Names,2);
numMissPair = size(MissingPairs,1);

debug =1;
if debug ==1

LoadDataName ='DataSetUnscaledDelta_Bvh.mat'

else 
LoadDataName =strcat('./DataSet_',num2str(numEmotion),'Em_',num2str(numActivity),'Act_',num2str(numActor),'Actor_',...
num2str(numMissPair),'MissPairs_0.2Test_0.1Val_0.7Train.mat') 
end
load(LoadDataName);
theta_dim = 2;
contextualVector = cell(numEmotion,1);% save thetas values
contextualVector{1,1} = [rand;rand];
contextualVector{2,1} = [rand;rand];
contextualVector{3,1} = [rand;rand];
contextualVector{4,1} = [rand;rand];
contextualVector{5,1} = [rand;rand];
contextualVector{6,1} = [rand;rand];
contextualVector{7,1} = [rand;rand];
contextualVector{8,1} = [rand;rand];
%isFixed = [0 0 0 1 0 0 0 0];

TrainingFPHMM_Synthesis;
TestFPHMM_Synthesis;
TestEmotionAccuracy_Synthesis;
%save all the variables into a file
ExperimentName = 'SynthesisExp002';
save_path = strcat(path0,'fullyParameterizedHMM/Project/recognition/activityRecognition/',ExperimentName,'/Results/');        
if isRandomInit ==1 
    str1 = 'RandInit';
else      
    str1 = 'fixedInit';
end     

if isNormalized ==1 
    str2 = 'Normalised';
else
    str2 = 'UnNormalised'
end 
timestr = clock();
save_file_name = strcat(save_path,num2str(numActivity),'Act_',num2str(numEmotion),'Em_',num2str(size(Names,2)),...
    'Actors_',num2str(theta_dim),'thetadim_',str1,'_',str2,'_',num2str(FPHMM_HMM_init_Iter),'+',num2str(mxIter_FPHMM),'FPHMM_Bvh',num2str(timestr(1)),'_',num2str(timestr(2)),'_',...
num2str(timestr(3)),'_',num2str(timestr(4)),'_',num2str(timestr(5)));
    
%saveas(allfigs,save_file_name,'png');
save('-mat7-binary',strcat(save_file_name,'.mat'));

