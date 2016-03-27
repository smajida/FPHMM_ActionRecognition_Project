#/urs/bin/bash

rename "PfSW_*WH" "PfSW" ./test*dim_theta*
DestFile="./test*dim_theta*"

for f in $DestFile
do
	sed -i -e "/subExperiment =/c subExperiment = 'Experiment5States007';" $f
	sed -i -e "/LoadDataName =/c LoadDataName = 'DataSetOffSet4thDim_RmFirst3Dims_UnScaled_20PCA_allTrainingSet_Bvh_MeanSub_eachActor_PfSW_Centered_005.mat';" $f
done

HMMFILE="test*HMM.m"
for h in $HMMFILE
do
	sed -i -e "/subExperiment =/c subExperiment = 'Experiment5States007';" $h
	sed -i -e "/LoadDataName =/c LoadDataName = 'DataSetOffSet4thDim_RmFirst3Dims_UnScaled_20PCA_allTrainingSet_Bvh_MeanSub_eachActor_PfSW_Centered_005.mat';" $h
done

