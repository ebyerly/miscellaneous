from primes import primes

def sieve(topvalue):
    if primes[-1] >= topvalue:
        return
    #  list from largest determined prime to topvalue
    list = range(primes[-1] + 1, topvalue + 1)	
    #  for instance, two, removes all even numbers
    for prime in primes:
        index = 0
        while prime * index <= topvalue:
            try:
                list.remove(prime * index)
            except:
                pass
            index += 1
    if len(list) > 0:
        primes.append(list[0])
    return sieve(topvalue)
	
	
def sieve(topvalue):
    if primes[-1] >= topvalue:
        return
    list = range(primes[-1] + 1,topvalue + 1)
	