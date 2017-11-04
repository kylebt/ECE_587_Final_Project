set -x
BENCHMARK="perl"
RESULT_DIR="./results/${BENCHMARK}"
RESULT_FILE="./results/${BENCHMARK}.out"
#SIMULATOR="/u/kyle35/Documents/ECE587/simulator/ss3/sim-outorder"
SIMULATOR="$PWD/ss3/sim-outorder"
SIM_ARGS="-fastfwd 100000000 -max:inst 10000000 -cache:dl2 ul2:1024:64:8:l"
#./Run.pl -db bench.db -dir $RESULT_DIR -benchmark $BENCHMARK -sim $SIMULATOR -args $SIM_ARGS >& $RESULT_FILE

if [ ! -d "$RESULT_DIR" ]; then
	mkdir -p $RESULT_DIR
fi

./Run.pl -db bench.db -dir "${RESULT_DIR}" -benchmark $BENCHMARK -sim $SIMULATOR -args "$SIM_ARGS" >& $RESULT_FILE
