set -x
BENCHMARK="gcc"
RESULT_DIR="./results/${BENCHMARK}"
RESULT_FILE="./results/${BENCHMARK}.out"
SIMULATOR="$PWD/ss3/sim-outorder"

#For 2 level branch predictor configuration:
# -bpred:2lev <l1size> <l2size> <shift_width> <xor bits? 1 = yes, 0 = no>
#    Sample predictors:
#      GAg     : 1, 2^W, W, 0
#      GAp     : 1, M (M > 2^W), W, 0
#      PAg     : N, 2^W, W, 0
#      PAp     : N, M (M == 2^(N+W)), W, 0
#      gshare  : 1, 2^W, W, 1

#Example of hybrid using nbpat and 2 level PAg
SIM_ARGS="-fastfwd 100000000 -max:inst 10000000 -bpred nbpat_hybrid -bpred:altpred 2lev -bpred:2lev 2048 256 8 0 -bpred:nbpat 2048 1"
#Example of hybrid using nbpat and GShare
#SIM_ARGS="-fastfwd 100000000 -max:inst 10000000 -bpred nbpat_hybrid -bpred:altpred 2lev -bpred:2lev 1 1024 10 1 -bpred:nbpat 65536 16"

#Example of hybrid using nbpat and bimodal (only param to bimod is the table size, each entry gets a 2 bit predictor)
#SIM_ARGS="-fastfwd 100000000 -max:inst 10000000 -bpred nbpat_hybrid -bpred:altpred bimod -bpred:bimod 2048 -bpred:nbpat 65536 16"


#Example of just nbpat
#SIM_ARGS="-fastfwd 100000000 -max:inst 10000000 -bpred nbpat -bpred:nbpat 4096 8"

if [ ! -d "$RESULT_DIR" ]; then
	mkdir -p $RESULT_DIR
fi

./Run.pl -db bench.db -dir "${RESULT_DIR}" -benchmark $BENCHMARK -sim $SIMULATOR -args "$SIM_ARGS" >& $RESULT_FILE
