#/usr/bin/bash
DEST="./test*.m"
for f in $DEST
do
	#sed -i -e "/^left2rightHMMtopology =/a cov_type = 'diag';" $f
	#sed -i -e "/^lefe2rightHMMtopology =/a orthogonal_constrain_W = 1;" $f
	sed -i -e "/^subExperiment =/c subExperiment = 'Experiment5States005-dig';" $f
done
