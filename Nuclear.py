# -*- coding: utf-8 -*-
"""
Created on Wed Aug 23 16:07:14 2017

@author: Noe
"""

import numpy as np
import matplotlib.pyplot as plt
#import tqdm
from peakdetector import detect_peaks

uno = np.loadtxt('C:/Users/Publico.LABORATORIOS/Desktop/sh 4, g10.txt')
cuatro = np.loadtxt('C:/Users/Publico.LABORATORIOS/Desktop/sh1, g10.txt')
doce = np.loadtxt('C:/Users/Publico.LABORATORIOS/Desktop/sh12, g10.txt')

for a, k in enumerate([uno, cuatro, doce]):
    plt.figure(1)
    peakidx = detect_peaks(k, mph = 0.02)
    peakval = k[peakidx]
    plt.plot(k,'r-')
    plt.plot(peakidx,peakval,'b.')
    plt.grid(True)
    plt.figure(2)
    plt.title('Pulsos medidos con ganancia 10 y shaping %s' %(['1', '4', '12'][a]))
    plt.hist(peakval)
    plt.grid(True)
    plt.title('Distribución de los pulsos medidos con ganancia 10 y shaping %s' %(['1', '4', '12'][a]))
    plt.show()



abierto = np.loadtxt('C:/Users/Publico.LABORATORIOS/Desktop/data abierto 5000.txt')



peakidxa = detect_peaks(abierto, mph = 0.0058)
peakvala = abierto[peakidxa]
plt.plot(abierto, 'g-')
plt.plot(peakidxa,peakvala, 'b.')
plt.grid(True)




