# Challenge level: Beginner

# Scenario: You have two files containing a list of email addresses of people who attended your events.
#       File 1: People who attended your Film Screening event
#       https://github.com/shannonturner/python-lessons/blob/master/section_09_(functions)/film_screening_attendees.txt
#"C:/Users/Elizabeth/Dropbox/Python/python-lessons/section_09_(functions)/film_screening_attendees.txt"
#
#       File 2: People who attended your Happy hour
#       https://github.com/shannonturner/python-lessons/blob/master/section_09_(functions)/happy_hour_attendees.txt
#"C:/Users/Elizabeth/Dropbox/Python/python-lessons/section_09_(functions)/happy_hour_attendees.txt"
#

# Goal 1: You want to get a de-duplicated list of all of the people who have come to your events.

myfilepathlist = ["C:/Users/Elizabeth/Dropbox/Python/python-lessons/section_09_(functions)/film_screening_attendees.txt","C:/Users/Elizabeth/Dropbox/Python/python-lessons/section_09_(functions)/happy_hour_attendees.txt"]

def remove_duplicates(from_list):
	"""converts a list to a set and back to a list, removing duplicates and retaining formatting."""
	return list(set(from_list))

def txt_to_emails(filepath):
	"""Takes a txt file of e-mails broken by newline and returns a list of e-mails"""
	with open(filepath,'r') as originaltext:
		emails = originaltext.read().split('/n')
	return emails
	
def txt_emails_merge(filepathlist):
	"""Takes a list of filepaths containing txt files of e-mails broken by newline and returns a master list of unduplicated e-mails"""
	all_emails = []
	for filepath in filepathlist:
		all_emails += txt_to_emails(filepath)
	return remove_duplicates(all_emails)

# Goal 2: Who came to *both* your Film Screening and your Happy hour?
def txt_emails_match(filepathlist):
	"""Takes a list of filepaths containing txt files of e-mails broken by newline and returns a master list of duplicated e-mails"""
	all_emails = []
	match_emails = []
	for filepath in filepathlist:
		all_emails += txt_to_emails(filepath)
	for email in all_emails:
		if all_emails.count(email) == len(filepathlist):
			match_emails += [email]
	return match_emails
