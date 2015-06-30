import newprimes as new
x = new.newprime()

while not len(new.primes) >= 10001:
	x.next()
	print new.primes[-1]
	
print new.primes[10000]