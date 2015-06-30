"""
A Pythagorean triplet is a set of three natural numbers for which a^2 + b^2 = c^2.
There exists exactly one Pythagorean triplet for which a + b + c = 1000.
Find the product, abc.
"""

# c > b > a (c is greater than a or b, we can define a and b as being unequal, irrelevant which is larger.
# potential values of c, range 334-998

initial = range(3, 998)
combos = []

for a in initial:
	for b in initial:
		if b > a and b+a >= 334:
			for c in initial:
				if c > b and c > 334:
					if sum([a,b,c]) == 1000:
						combos.append([a*b*c,a,b,c])

for combo in combos:
	if combo[0] == combo[1]:
		print combo