"""
2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.

What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
"""

x = 2520
divided = False
while not divided:
	for divisor in range(11,21):
		if x % divisor != 0:
			break
		if divisor == 20:
			print x
			divided = True
	x += 2520