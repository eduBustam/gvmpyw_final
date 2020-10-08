#include "wraputil.cuh"

Synthesizer * wrapSynth(){
        enum {MFS}; // Synthesizer
        return (Singleton<SynthesizerFactory>::Instance().CreateSynthesizer(MFS));
}
Optimizator * wrapOpti(){
        enum {CG,LBFGS}; // Synthesizer
        return (Singleton<OptimizatorFactory>::Instance().CreateOptimizator(CG));
}
ObjectiveFunction * wrapOf(){
        enum {DefaultObjectiveFunction}; // ObjectiveFunction
        return (Singleton<ObjectiveFunctionFactory>::Instance().CreateObjectiveFunction(DefaultObjectiveFunction));
}
Io * wrapIo(){
        enum {MS}; // Io
        return (Singleton<IoFactory>::Instance().CreateIo(MS)); // This is the default Io Class
}
Fi * wrapFi(int id){
        enum {Chi2, Entropy, Laplacian, QuadraticPenalization, TotalVariation, TotalSquaredVariation, L1Norm};
        if(id==0)
                return(Singleton<FiFactory>::Instance().CreateFi(Chi2) );
        else if(id==1)                
                return (Singleton<FiFactory>::Instance().CreateFi(Entropy));
        else if(id==2)       
                return(Singleton<FiFactory>::Instance().CreateFi(Laplacian));
        else if(id==3)
                return (Singleton<FiFactory>::Instance().CreateFi(QuadraticPenalization));
        else if(id==4)
                return(Singleton<FiFactory>::Instance().CreateFi(QuadraticPenalization));
        else if(id==5)
                return(Singleton<FiFactory>::Instance().CreateFi(QuadraticPenalization));
        else if(id==6)
                return(Singleton<FiFactory>::Instance().CreateFi(QuadraticPenalization));
}
int checkRequirements(){
        cudaGetDeviceCount(&num_gpus);

        printf("gpuvmem Copyright (C) 2016-2017  Miguel Carcamo, Pablo Roman, Simon Casassus, Victor Moral, Fernando Rannou, Nicolás Muñoz - miguel.carcamo@protonmail.com\n");
        printf("This program comes with ABSOLUTELY NO WARRANTY; for details use option -w\n");
        printf("This is free software, and you are welcome to redistribute it under certain conditions; use option -c for details.\n\n\n");


        if(num_gpus < 1) {
                printf("No CUDA capable devices were detected\n");
                return 1;
        }
}
