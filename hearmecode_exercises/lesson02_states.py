states_abbr = []
states = []

with open('states.txt','r') as states_file:
	stateslist = states_file.read().split('\n')
	for value in stateslist:
		states_abbr.append(value.split('\t')[0])
		states.append(value.split('\t')[1])

statestr = '<select>'
for state in range(len(states)):
	statestr = statestr + '\n    <option value="{0}">{1}</option>'.format(states_abbr[state], states[state])
statestr = statestr + '</select>'

with open('state.html', 'w') as doc:
	doc.write(statestr)
	
