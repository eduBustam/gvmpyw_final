#ifndef WRAPUTIL_CUH
#define WRAPUTIL_CUH

#include "frprmn.cuh"
#include "directioncosines.cuh"
#include <time.h>

Synthesizer * wrapSynth();
Optimizator * wrapOpti();
ObjectiveFunction * wrapOf();
Io * wrapIo();
Fi * wrapFi(int);
int checkRequirements();

#endif
