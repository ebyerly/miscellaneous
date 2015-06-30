"""
Find the largest palindrome made from the product of two 3-digit numbers.
ie, 91 * 99 = 9009
"""
palindromes = []
highvalue = None
for n in reversed(range(100, 1000)):
	for x in reversed(range(100, 1000)):
		value = str(n * x)  #  9999 becomes '9999'
		length = len(value)  #  '9999' has length = 4
		palindrome = True
		for index in range(int(length/2)):  #  range(2)
			if not value[index] == value[-(index+1)]:  #  checks value[0]==[-1],[1]==[-2]
				palindrome = False
		if palindrome:
			palindromes.append(n*x)
			highvalue = x
			break
	if n <= highvalue:
		break
print max(palindromes)