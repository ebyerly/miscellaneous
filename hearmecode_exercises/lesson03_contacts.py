# Challenge Level: Beginner

# NOTE: Please don't use anyone's *real* contact information during these exercises, especially if you're putting it up on Github!

# Background: You have a dictionary with people's contact information.  You want to display that information as an HTML table.

contacts = {
    'Shannon': {'phone': '202-555-1234', 'twitter': '@svt827', 'github': '@shannonturner' },
    'Beyonce': {'phone': '303-404-9876', 'twitter': '@beyonce', 'github': '@bey'},
    'Tegan and Sara': {'phone': '301-777-3313', 'twitter': '@teganandsara', 'github': '@heartthrob'}
}

# Goal 1: Loop through that dictionary to print out everyone's contact information.

for contact, info in contacts.items():
	print """{0}'s contact information is:
	Phone: {1}
	Twitter: {2}
	Github: {3}
	""".format(contact, info.get('phone'), info.get('twitter'), info.get('github'))


# Goal 2:  Display that information as an HTML table.

# Sample output:

# <table border="1">
# <tr>
# <td colspan="2"> Shannon </td>
# </tr>
# <tr>
# <td> Phone: 202-555-1234 </td>
# <td> Twitter: @svt827 </td>
# <td> Github: @shannonturner </td>
# </tr>
# </table>

html_string = ""

for contact, info in contacts.items():
	html_string += """<table border="1">
<tr>
<td colspan="2"> {0} </td>
</tr>
<tr>
<td> Phone: {1} </td>
<td> Twitter: {2} </td>
<td> Github: {3} </td>
</tr>
</table>
	""".format(contact, info.get('phone'), info.get('twitter'), info.get('github'))

# Goal 3: Write all of the HTML out to a file called contacts.html and open it in your browser.

with open('contacts.html','w') as newfile:
	newfile.write(html_string)

# Goal 4: Instead of reading in the contacts from the dictionary above, read them in from contacts.csv, which you can find in lesson_07_(files).

file_contacts = {}

with open("python-lessons\section_07_(files)\contacts.csv",'r') as contacts_file:
	contacts_string = contacts_file.read().split('\n')[1:]

for contact in contacts_string:
	contactlist = contact.split(',')
	file_contacts[contactlist[0]]={'phone' : contactlist[1], 'twitter' : contactlist[2], 'github' : contactlist[3]}
	
