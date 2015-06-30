"""
The sum of the squares of the first ten natural numbers is 385
The square of the sum of the first ten natural numbers is 3025
Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025  385 = 2640.

Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.
"""

initial = range(101)
sumofsquares = []
for value in initial:
	sumofsquares.append(value*value)
sumofsquares = sum(sumofsquares)
squaredsum = sum(initial)*sum(initial)
print squaredsum - sumofsquares