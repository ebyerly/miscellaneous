# Challenge level: Beginner

# Goal: Using the code from Lesson 3: File handling and dictionaries, create a function that will open a CSV file and return the result as a nested list.

def csv_to_nested_list(filepath):
	"""Takes a .csv filepath and returns a nested list of values."""
	outputlist = []

	with open(filepath,'r') as file:
		firstlist = file.read().split('\n')

	for alist in firstlist:
		blist = alist.split(',')
	
	return blist