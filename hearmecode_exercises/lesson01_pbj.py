# Peanut Butter Jelly Time!

peanutbutter = 3
jelly = 0
bread = 2


wholesand = min(peanutbutter, jelly, bread/2)
halfsand = False
if(jelly - wholesand) and (peanutbutter - wholesand) and (bread%2) >= 1:
	halfsand = True

if wholesand:
	zero = wholesand
	one = "es"
	two = ""
	if wholesand == 1:
		zero = "a"
		one = ""
	if halfsand:
		two = " and one on open-face bread"
	print "You can enjoy {0} peanut butter and jelly sandwich{1}{2}.".format(zero, one, two)
elif halfsand:
	print "You have enough for one open-faced peanut butter and jelly sandwich."
elif peanutbutter and bread >= 1:
	if bread == 1:
		print "You can make one open-faced peanut butter sandwich. That's... kind of sad, though."
	else:
		print "You can make a sandwich with only peanut butter and bread, but that's... Well, that's kind of sad."
else:
	print "You do not have what you need to enjoy a peanut butter and jelly sandwich!"
	if peanutbutter == 0:
		print "You need at least some peanut butter."
	if jelly == 0:
		print "You need at least some jelly."
	if bread == 0:
		print "You need at least some bread."