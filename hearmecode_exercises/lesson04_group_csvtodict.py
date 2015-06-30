# Challenge Level: Advanced

# Group exercise!

# Scenario: Your organization has put on three events and you have a CSV with details about those events
#           You have the event's date, a brief description, its location, how many attended, how much it cost, and some brief notes
#           File: https://github.com/shannonturner/python-lessons/blob/master/section_09_(functions)/events.csv

# Goal: Read this CSV into a dictionary.

def csv_to_dict(filepath, primary_column=None):
	""""Takes a csv filepath, a string representing a column heading to be used as reference and returns two dictionaries.
	First dictionary: row number matched to primary column (ie, primary_column_value1 : 1)
	Second dictionary: row number matched to a dictionary of all columns used as keys to that row's column values (ie, 1 : {column1_title : row1_value, ...})"""
	# opens CSV and returns a list of rows with internal values delimited by ','
	with open(filepath,'r') as csvfile:
		rows_list = csvfile.read().split('\n')
	
	# defines first row from CSV as a list of column titles
	titles_list = rows_list[0].split(',')
	
	# checks if user provided a primary_column; if not, uses first column title by default. Sets an index value for primary column's location.
	if primary_column is None:
		primary_column = titles_list[0]
		primary_index = 0
	else:
		primary_index = titles_list.index(primary_column)
	
	# defines list of of lists of row values
	values = []
	for row_list in rows_list[1:]:
		values.append(row_list.split(','))
	
	# creates and populates primary_column_value-to-row_int dictionary
	first_dict = {}
	for index, rowvalues_list in enumerate(values):
		first_dict[rowvalues_list[primary_index]] = index
	
	# creates and populates row-to-values dictionary
	second_dict = {}
	# {0 : {'date' : '2010-01-01', ...}, 1 : {'date' : '2010-01-01', ...}}
	for valueindex, rowvalues_list in enumerate(values):
		second_dict[valueindex] = {}
		for titleindex, title in enumerate(titles_list):
			second_dict[valueindex][title] = rowvalues_list[titleindex]
			
	return first_dict, second_dict