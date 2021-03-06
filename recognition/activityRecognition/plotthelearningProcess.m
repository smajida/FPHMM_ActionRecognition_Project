if theta_dim == 1;
	for indFold = 1:K
		
		tmpThetasCell = K_CV_FPHMMCell{indFold,1}{1,1}{8,1}
		RowNum = size(tmpThetasCell,1);
		ColNum = size(tmpThetasCell,2);
		tmpMat = zeros(RowNum,ColNum);
		for i = 1:RowNum
			for j = 1:ColNum
				tmpMat(i,j) = tmpThetasCell{i,j};
			end
		end
		figure;
		plot(tmpMat(:,1),tmpMat(:,2),'b--o');
	%         axis([min(tmpMat(:,1))-0.2,max(tmpMat(:,1))+0.2,min(tmpMat(:,2)-0.2,max(tmpMat(:,2))+0.2),2]);

		
	end

% %save variables 
% str = strcat(num2str(K),'K_',num2str(numEmotion),'Em_',num2str(numActivity),'Act_',...
%     num2str(FPHMM_HMM_init_Iter),'+',num2str(mxIter_FPHMM),'FPHMM_converged');
% save()
%%
%delete(findall(0,'Type','figure'))

%if theta is 2-dimensional
elseif  theta_dim == 2;
	for indFold = 1:K
		size(K_CV_FPHMMCell{indFold,1})
		size(K_CV_FPHMMCell{indFold,1}{1,1})
		tmpThetasCell = K_CV_FPHMMCell{indFold,1}{1,1}{8,1}
		numIteration = size(tmpThetasCell,1)
		numEm = size(tmpThetasCell,2)

		for i = 1:numEm
			tmpMat = zeros(numIteration,theta_dim);
		%	tmpMat(1,:) = initTheta{indFold,1}{i,1}';
			
			for j = 1:numIteration
				tmpThetasCell{j,i}
				tmpMat(j,:) = tmpThetasCell{j,i}'
				fprintf('j = %d\n',j)
			end
	%         figure;
			plot(tmpMat(:,1),tmpMat(:,2),'b--o');
			str = ['\leftarrow ' emotionCell{1,i}];
			text(tmpMat(2,1),tmpMat(2,2),str,'Color','blue','FontSize',14);
			str1 = '\rightarrow initial point';
			text(tmpMat(1,1),tmpMat(1,2),str1,'Color','blue','FontSize',14);
			hold on;
			
		end
		hold off;
	%         axis([min(tmpMat(:,1))-0.2,max(tmpMat(:,1))+0.2,min(tmpMat(:,2)-0.2,max(tmpMat(:,2))+0.2),2]);

		
	end
	%allfigs = findall(0,'Type','figure');
	%save_path = strcat(path0,'fullyParameterizedHMM/Project/recognition/activityRecognition/testConvergeOfThetas/');
	%save_file_name = strcat(save_path,num2str(numActivity),'Act_',num2str(numEm),'Em_',num2str(size(Names,2)),...
	%	'Actors_',num2str(theta_dim),'thetadim_','RandInit_',num2str(FPHMM_HMM_init_Iter),'+',num2str(mxIter_FPHMM),'FPHMM_converged03');

	%savefig(allfigs,save_file_name,'compact');
	%save(save_file_name,'K_CV_FPHMMCell');

%% 3d thetas

%if theta is 2-dimensional
elseif theta_dim >= 3;
	for indFold = 1:K
		
		tmpThetasCell = K_CV_FPHMMCell{indFold,1}{1,1}{8,1}
		numIteration = size(tmpThetasCell,1);
		numEm = size(tmpThetasCell,2);

		for i = 1:numEm
			tmpMat = zeros(numIteration,theta_dim);
			%tmpMat(1,:) = initTheta{indFold,1}{i,1}';
			
			for j = 1:numIteration
				tmpMat(j,:) = tmpThetasCell{j,i}';
			end
	%         figure;
			plot3(tmpMat(:,1),tmpMat(:,2),tmpMat(:,3),'b--o');
			str = ['\leftarrow ' emotionCell{1,i}];
			text(tmpMat(2,1),tmpMat(2,2),tmpMat(2,3),str,'Color','blue','FontSize',14);
			str1 = '\rightarrow initial point';
			text(tmpMat(1,1),tmpMat(1,2),tmpMat(1,3),str1,'Color','blue','FontSize',14);
			hold on;
			
		end
		hold off;
	%         axis([min(tmpMat(:,1))-0.2,max(tmpMat(:,1))+0.2,min(tmpMat(:,2)-0.2,max(tmpMat(:,2))+0.2),2]);

		
	end
end
%plot and save figs
allfigs = findall(0,'Type','figure')
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
    'Actors_',num2str(theta_dim),'thetadim_',str1,'_',str2,'_',num2str(FPHMM_HMM_init_Iter),'+',num2str(mxIter_FPHMM),'FPHMM_',num2str(timestr(1)),'_',num2str(timestr(2)),'_',...
num2str(timestr(3)),'_',num2str(timestr(4)),'_',num2str(timestr(5)));

%saveas(allfigs,save_file_name,'png');
save('-mat7-binary',strcat(save_file_name,'.mat'));
