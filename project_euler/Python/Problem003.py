"""
The prime factors of 13195 are 5, 7, 13 and 29.

What is the largest prime factor of the number 600851475143 ?
"""

import newprimes as np

x = np.newprime()
primeindex = 0
checkvalue = 600851475143
top = int(checkvalue/np.primes[primeindex])
bottom = np.primes[-1]

greatestprimefactor = None

while top > bottom:
	if checkvalue % np.primes[primeindex] == 0:
		greatestprimefactor = np.primes[primeindex]
	primeindex += 1
	if np.primes[primeindex] == np.primes[-1]:
		x.next()
	top = int(checkvalue/np.primes[primeindex])
	bottom = np.primes[-1]
	print str(top) + "   " + str(bottom)
		
print greatestprimefactor