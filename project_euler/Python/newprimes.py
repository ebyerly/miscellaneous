from primes import primes

def newprime(n=(primes[-1]+2)):
	isprime= False
	while not isprime:
		for prime in primes:
			if n % prime == 0:
				isprime = False
				break
			else:
				isprime = True
		if isprime:
			primes.append(n)
			f = open('primes.py', 'w')
			f.write('primes = {0}'.format(str(primes)))
			f.close()
			yield n
		n +=2
		isprime = False