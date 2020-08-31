"""MKS Chord Length Module

For computing chord length distribtion of the binay(segmented) image
under assumption of non-periodic boundary conditions
"""
import numpy as np

def CLD(image):
    # Add system check if image is douoble or not.
    A=img/255
    B = ndimage.convolve1d(A, np.array([0,-1,1]),mode='wrap')
    XL,YL = numpy.where(B==1)
    XR,YR= numpy.where(B==-1)
    chords=np.histogram(XL-XR, bins=np.arange(0.5,dimen[1]+0.5))
    return chords
