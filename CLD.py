"""MKS Chord Length Module

For computing chord length distribtion of the binay(segmented) image
under assumption of non-periodic boundary conditions
"""
import numpy as np
from scipy import ndimage

def CLD(image,direction):
    # Add system check if image is douoble or not.
    if direction =='x':
        pass

    elif direction =='y':
        image=np.transpose(image)
    else:
        print("Please select the correct direction x or y ")

    if np.max(image)==1:
        A=image
    else:
         A=image/255

        
    dimen=np.shape(image)
    B = ndimage.convolve1d(A, np.array([0,-1,1]),mode='wrap')
    XL,YL = np.where(B==1)
    XR,YR= np.where(B==-1)
    chords=np.histogram(YL-YR, bins=np.arange(0.5,dimen[1]+0.5))
    return chords
