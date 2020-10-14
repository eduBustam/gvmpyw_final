import numpy as np
cimport numpy as np
assert sizeof(int) == sizeof(np.int32_t)

from libc.string cimport strcpy, strlen
from libc.stdlib cimport malloc, free


#Python a C char**
cdef char* hello_world = 'pystr_list'
cdef Py_ssize_t n = strlen(hello_world)

cdef char* c_call_returning_a_c_string():
    cdef char* c_string = <char *> malloc((n + 1) * sizeof(char))
    if not c_string:
        raise MemoryError()
    strcpy(c_string, hello_world)
    return c_string


cdef void get_a_c_string(char** c_string_ptr, Py_ssize_t *length):
    c_string_ptr[0] = <char *> malloc((n + 1) * sizeof(char))
    if not c_string_ptr[0]:
        raise MemoryError()

    strcpy(c_string_ptr[0], hello_world)
    length[0] = n
#cdef extern from "src/test.cuh":
#    void hello()
    
#def py_hello():
#    hello()

#cdef extern from "src/manager.cuh":
#    cdef cppclass C_GPUAdder "GPUAdder":
#        C_GPUAdder(np.int32_t*, int)
#        void increment()
#        void retreive()
#        void retreive_to(np.int32_t*, int)

#cdef class GPUAdder:
#    cdef C_GPUAdder* g
#    cdef int dim1

#    def __cinit__(self, np.ndarray[ndim=1, dtype=np.int32_t] arr):
#        self.dim1 = len(arr)
#        self.g = new C_GPUAdder(&arr[0], self.dim1)
#
#    def increment(self):
#        self.g.increment()
#
#    def retreive_inplace(self):
#        self.g.retreive()

#    def retreive(self):
#        cdef np.ndarray[ndim=1, dtype=np.int32_t] a = np.zeros(self.dim1, dtype=np.int32)
#
#        self.g.retreive_to(&a[0], self.dim1)
#
#        return a


#De arriba pa abajo
#Structs
cdef extern from "gpuvmem/include/framework.cuh":
    cdef struct cufftComplex:
        pass
    ctypedef cufftComplex* cufftComplex

    cdef struct MSDataset:
        pass
    ctypedef MSDataset* MSDataset

    cdef struct MSData:
        pass
    ctypedef MSData* MSData     
    cdef struct canvas_variables:
        pass
    ctypedef canvas_variables* canvasVaribles
    cdef struct field:
        pass
    ctypedef field* Field

    cdef struct fitsfile:
        pass
    ctypedef fitsfile* fitsfiles
    
    cdef struct varsPerGpu:
        pass
    ctypedef varsPerGpu* varsPerGpu
    cdef struct variables:
        pass
    ctypedef variables* Vars

    cdef struct functionMap:
        pass
    ctypedef functionMap* imageMap
    cdef struct canvas_variables:
        pass
    ctypedef canvas_variables* canvasVariables
#Constructores
cdef extern from "gpuvmem/include/wraputil.cuh":
    Synthesizer* wrapSynth()
    Optimizator * wrapOpti()
    ObjectiveFunction * wrapOf()
    Io * wrapIo()
    Fi * wrapFi(int id)
    int checkRequirements()

#Classes
cdef extern from "gpuvmem/include/framework.cuh":
    cdef cppclass VirtualImageProcessor:
        void clip(float *I)
        void clipWNoise(float *I)
        void apply_beam(cufftComplex *image, float, float, float, float, float, float)
        void calculateInu(cufftComplex *image, float *I, float)
        void chainRule(float *I, float)
        void configure(int)

    cdef cppclass Fi:
        float calcFi(float *p)
        void calcGi(float *p, float *xi)
        void configure(int, int , int )
        void setPenalizationFactor(float p)
        float getPenalizationFactor()

    cdef cppclass Image:
        Image(float *image, int)
        int getImageCount()
        float *getImage()
        float *getErrorImage()
        void setImageCount(int)
        void setErrorImage(float *f)
        void setImage(float *i)

    cdef cppclass Visibilities:
        void setMSDataset(MSDataset *d)
        MSDataset *getMSDataset()

    cdef cppclass Error:
        void calculateErrorImage(Image *I, Visibilities *v)

    cdef cppclass Filter:
        pass
    cdef cppclass Io:
        MSData IocountVisibilities(char *MS_name, Field *&fields, int ) 
        canvasVariables IoreadCanvas(char *canvas_name, fitsfile *&canvas, float , int , int ) 
        void IoreadMS(char *MS_name, Field *fields, MSData data, bool , bool , float ) 
        void IowriteMS(char *infile, char *outfile, Field *fields, MSData data, float , bool , bool , bool , int ) 
        void IocloseCanvas(fitsfile *canvas) 
        void IoPrintImage(float *I, fitsfile *canvas, char *path, char *name_image, char *units, int , int , float , long M, long N)
        void IoPrintImageIteration(float *I, fitsfile *canvas, char *path, char *name_image, char *units, int , int , float , long M, long N) 
        void IoPrintMEMImageIteration(float *I, char *name_image, char *units, int ) 
        void IoPrintcuFFTComplex(cufftComplex *I, fitsfile *canvas, char *out_image, char *mempath, int , float , long , long , int )
        void setPrintImagesPath(char * pip)

    cdef cppclass ObjectiveFunction:
        ObjectiveFunction()
        void addFi(Fi *fi)
        float calcFunction(float *p)
        void calcGradient(float *p, float *xi)
        void restartDPhi()
        void copyDphiToXi(float *xi)
        void setN(long N)
        void setM(long M)
        void setImageCount(int)
        void setIo(Io *i)
        void setPrintImages(int)
        void setIoOrderIterations(void (*func)(float *I, Io *io))
        void configure(long N, long M, int I)

    cdef cppclass Optimizator:
        void setImage(Image *image)
        void setObjectiveFunction(ObjectiveFunction *of)
        void setFlag(int flag)
        ObjectiveFunction* getObjectiveFuntion()
    cdef cppclass Filter:
        pass
    
    cdef cppclass Synthesizer:
        void run()
        void setOutPut(char * FileName)
        void setDevice()
        void unSetDevice()
        void configure(int argc, char **argv)
        void applyFilter(Filter *filter)
        Image *getImage()
        void setImage(Image *i)
        void setOptimizator(Optimizator* op)
        void setIoHandler(Io* io)
        void setGriddingKernel(CKernel *ckernel)
    cdef cppclass CKernel:
        pass

cdef class SynthesizerPY:
    cdef Synthesizer *synt
    def __cinit__(self):
        self.synt=wrapSynth()

    def __dealloc__(self):
        del self.synt

    def setOptimizator(self,OptimizatorPY opin):
        self.synt.setOptimizator(opin.op)

    def setIoHandler(self, IoPY ioin):
        self.synt.setIoHandler(ioin.io)

    def setImage(self, Py_Image ima):
        self.synt.setImage(ima.img)

    def configure(self,pystr):
        cdef char** c_argv
        c_argv = <char**>malloc(len(pystr) * sizeof(char*))
        if c_argv is NULL:
            raise MemoryError()
        for i in range(len(pystr)):
            pystr[i] = pystr[i].encode()
            c_argv[i] = pystr[i]
        self.synt.configure(len(pystr),c_argv)
        free(c_argv)
    def setDevice(self):
        self.synt.setDevice()

    def unsetDevice(self):
        self.synt.unSetDevice()

    def run(self):
        self.synt.run()

cdef class FiPY:
    cdef Fi* fi
    def __cinit__(self,int id):
        self.fi=wrapFi(id)
    def __dealloc__(self):
        del self.fi
    def configure(self,int A,int B,int C):
        self.fi.configure(A,B,C)
    def setPenalizationFactor(self,float A):
        self.fi.setPenalizationFactor(A)

cdef class OptimizatorPY:
    cdef Optimizator *op
    def __cinit__(self):
        self.op=wrapOpti()
    def __dealloc__(self):
        del self.op
    def setObjectiveFunction(self,ObjectiveFunctionPY obj):
        self.op.setObjectiveFunction(obj.of)

cdef class ObjectiveFunctionPY:
    cdef ObjectiveFunction *of
    def __cinit__(self):
        self.of=wrapOf()
    def __dealloc__(self):
        del self.of
    def addFi(self,FiPY fiin):
        self.of.addFi(fiin.fi)

cdef class IoPY:
    cdef Io *io
    def __cinit__(self):
        self.io=wrapIo()
    def __dealloc__(self):
        del self.io

cdef class Py_Image:
    cdef Image *img
    def __cinit__(self,np.ndarray[ndim=1, dtype=np.float32_t] arr,int b):
        self.img= new Image(&arr[0],b)
    def __dealloc__(self):
        del self.img

    def py_getImageCount(self):
        return self.img.getImageCount()
    def py_setImageCount(self,int a):
        self.img.setImageCount(a)

    def py_getImage(self, int size):
        #return self.img.getImage()
        return <float[:size]>self.img.getImage() #La base del problema es que debo crear un np array del mismo tamaño que el return de la funcion, sin conocer sus dimensiones
    def py_setImage(self,np.ndarray[ndim=1, dtype=np.float32_t] arr):
        self.img.setImage(&arr[0])
    
    def py_getErrorImage(self,int size):
        return <float[:size]> self.img.getErrorImage() #Lo mismo que getImage
    def py_setErrorImage(self,np.ndarray[ndim=1, dtype=np.float32_t] arr):
        self.img.setErrorImage(&arr[0])

def pyCheck():
    return checkRequirements()











