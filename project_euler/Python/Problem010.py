"""
Find the sum of all primes below two million.
"""
import newprimes as new
x = new.newprime()
sumlist = []

while new.primes[-1]<2000000:
	x.next()
	
for value in new.primes:
	if value < 2000000:
		sumlist.append(value)
print sum(sumlist)