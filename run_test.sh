#! /bin/bash

NNODE=3
NTASK=120

OUTPUT=`printf "mom6_N%02g_n%03g_%%j.out" $NNODE $NTASK`
ERR=`printf "mom6_N%02g_n%03g_%%j.err" $NNODE $NTASK`

echo $OUTPUT $ERR
awk -v N=$NNODE -v  n=$NTASK -v out=$OUTPUT -v err=$ERR \
    '{gsub("<NODE>", N); gsub("<TASK>", n); gsub("<STDOUT>", out); gsub("<STDERR>", err); print}' submit.sh_template > submit.sh

previous_jobid=$(sbatch --parsable submit.sh)

while read NNODE NTASK
do
    OUTPUT=`printf "mom6_N%02g_n%03g_%%j.out" $NNODE $NTASK`
    ERR=`printf "mom6_N%02g_n%03g_%%j.err" $NNODE $NTASK`

    echo $OUTPUT $ERR

    awk -v N=$NNODE -v  n=$NTASK -v out=$OUTPUT -v err=$ERR \
	'{gsub("<NODE>", N); gsub("<TASK>", n); gsub("<STDOUT>", out); gsub("<STDERR>", err); print}' submit.sh_template > submit.sh
    previous_jobid=$(sbatch --parsable --dependency=afterok:$previous_jobid submit.sh)
done < node_task.dat

