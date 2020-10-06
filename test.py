import sys
sys.settrace
import numpy as np
import numpy.testing as npt
import gvmpyw


def test2():
    print ("asdasd")
    obj_test=gvmpyw.PyTest(2,4)
    obj_test.py_setA(456)
    a=obj_test.py_getA()
    print(a)
def oftest():
    print("sad")
    of=gvmpyw.Py_Optimizator
    print(of)
#def eltest():
#    print(gvmpyw.py_supermain())
def imagetest():
    a=np.float32([1.0,2.3,4.5])
    b=np.float32([3.655,76.37,23.566])
    #print(a)
    ig=gvmpyw.Py_Image(a,3)#instancio el objeto image
    ig.py_setImage(b)
    c=ig.py_getImage(3)#tomo lo que hay en image, el prblema del get es que necesito saber cuantos elementos tiene el array en este caso 3,pero en gpuvmen esto va a ser dinamico
    for i in range(0, len(c)):
        print(c[i])#se printea
    print(ig.py_getImageCount())
def settest():
    weIn=gvmpyw.pyCheck()
    
    sy=gvmpyw.SynthesizerPY()
    cg=gvmpyw.OptimizatorPY()
    of=gvmpyw.ObjectiveFunctionPY()
    io=gvmpyw.IoPY()

    sy.setIoHandler(io)

    co65=["./gpuvmem","-X","16","-Y","16","-V","256","-i","co65/co65.ms","-o","co65/residuals.ms","-O","co65/mod_out.fits","-m","co65/mod_in_0.fits","-I","co65/input.dat","-p", "co65/mem/","-z", "0.001", "-Z", "0.01,0.05", "-g", "1", "-t", "500000000", "--verbose"]
    FREQ78=["./gpuvmem","-i","FREQ78/FREQ78.ms","-o","FREQ78/residuals.ms","-O","FREQ78/mod_out.fits","-m","FREQ78/mod_in_0.fits","-I","FREQ78/input.dat","-p","FREQ78/mem/","-X","16","-Y","16","-V" ,"256", "-z", "0.001","-Z" ,"0.005,0.0","-t","500000000","-g","2" ,"--verbose","--print-images"]
    antennae=["./gpuvmem","-i", "antennae/all_fields.ms", "-o", "antennae/residuals.ms", "-O", "antennae/mod_out.fits", "-m", "antennae/mod_in_0.fits", "-I", "antennae/input.dat", "-p", "antennae/mem/", "-X", "16", "-Y", "16", "-V", "256", "-z", "0.001", "-Z", "0.01,0.0" ,"-g", "1", "-R", "2.0" ,"-t" ,"500000000", "--print-images", "--verbose"]
    M87=["./gpuvmem","-s","0","-i","M87/SR1_M87_2017_101_hi_hops_netcal_StokesI.selfcal.LLRR.ms","-o","M87/residuals.ms","-O","M87/mod_out.fits","-m","M87/mod_in_0.fits","-I","M87/input.dat","-p","M87/mem/","-X","16","-Y","16","-V","256","--verbose","--print-images","-z","0.001","-Z","5e-6,5e-5","-t","500000000"]
    M872=["./gpuvmem","-s","0","-i","M87/SR1_M87_2017_101_hi_hops_netcal_StokesI.selfcal.LLRR.ms","-o","M87/residuals.ms","-O","M87/mod_out.fits","-m","M87/mod_in_0.fits","-I","M87/input.dat","-p","M87/mem/","-X","16","-Y","16","-V","256","--verbose","--print-images","-z","0.001","-Z","5e-6,5e-5","-t","500000000"]
    selfcalband9=["./gpuvmem","-i","selfcalband9/hd142_b9cont_self_tav.ms","-o","selfcalband9/residuals.ms","-O","selfcalband9/mod_out.fits","-m","selfcalband9/mod_in_0.fits","-I","selfcalband9/input.dat","-p","selfcalband9/mem/","-X","16","-Y","16","-V","256","--verbose","-z","0.001","-Z","0.05,0.0","-t","500000000","-g","1","--print-images"]
    sy.configure(co65)
    cg.setObjectiveFunction(of)
    sy.setOptimizator(cg)

    sy.setDevice()

    chi2=gvmpyw.FiPY(0)
    e=gvmpyw.FiPY(1)
    l=gvmpyw.FiPY(2)

    chi2.configure(-1,0,0)
    e.configure(0,0,0)
    l.configure(1,0,0)
    
    of.addFi(chi2)
    of.addFi(e)
    of.addFi(l)
    
    sy.run()
    sy.unsetDevice()
    #28 ./gpuvmem-X16-Y16-V256-ico65/co65.ms-oco65/residuals.ms-Oco65/mod_out.fits-mco65/mod_in_0.fits-Ico65/input.dat-pco65/mem/-z0.001-Z0.01,0.05-g1-t500000000--verbose
    #27 -X16-Y16-V256-ico65/co65.ms-oco65/residuals.ms-Oco65/mod_out.fits-mco65/mod_in_0.fits-Ico65/input.dat-pco65/mem/-z0.5-Z0.01,0.05-g1-t500000000--verbose
settest()