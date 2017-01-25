#!/bin/bash
#script usage ./RunQueries.sh SCALE_FACTOR
if [ $# -ne 2 ]
then
	echo "Usage: ./RunQueries.sh SCALE_FACTOR [Database Prefix]"
	exit 1
fi

BENCH_HOME=$( cd "$( dirname "${BASH_SOURCE[0]}" )/../../" && pwd );
echo "\$BENCH_HOME is set to $BENCH_HOME";

BENCHMARK=HivePerformanceAutomation

RESULT_DIR=$BENCH_HOME/$BENCHMARK/results/
mkdir -p $RESULT_DIR
mkdir -p $RESULT_DIR/logs
chmod -R 777 $RESULT_DIR

LOG_DIR=$BENCH_HOME/$BENCHMARK/logs/
mkdir $LOG_DIR

# Initialize log file for data loading times
LOG_FILE_EXEC_TIMES="${BENCH_HOME}/${BENCHMARK}/logs/query_times.csv"
if [ ! -e "$LOG_FILE_EXEC_TIMES" ]
  then
	touch "$LOG_FILE_EXEC_TIMES"
	chmod 777 $LOG_FILE_EXEC_TIMES
    echo "QUERY,DURATION_IN_SECONDS,STARTTIME,STOPTIME,BENCHMARK,DATABASE,SCALE_FACTOR,FILE_FORMAT" >> "${LOG_FILE_EXEC_TIMES}"
fi

if [ ! -w "$LOG_FILE_EXEC_TIMES" ]
  then
    echo "ERROR: cannot write to: $LOG_FILE_EXEC_TIMES, no permission"
    return 1
fi

for i in {1..22}
do
./TpchQueryExecute.sh $1 $2 $i
done
