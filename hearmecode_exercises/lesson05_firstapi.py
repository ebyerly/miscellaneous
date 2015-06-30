# Exercise: Using your first API
# API documentation: http://bechdeltest.com/api/v1/doc

import requests

def btRetrieval():
	usermovie = input("Which movie's information would you like to retrieve from the Bechdel Test website?\n> ")
	
	if usermovie[0:4].lower() == 'the ':
		usermovie = usermovie.lower().replace('the ', '')
		
	try:
		if len(usermovie)==7:
			int(usermovie)
			bt_title = requests.get('http://bechdeltest.com/api/v1/getMovieByImdbId', params= {'imdbid' : usermovie}).json()
		else:
			bt_title = requests.get('http://bechdeltest.com/api/v1/getMoviesByTitle', params={'title' : usermovie}).json()
			if len(bt_title) == 0:
				print("I'm sorry, that movie wasn't found.")
				return btRetrieval()
	except:
		bt_title = requests.get('http://bechdeltest.com/api/v1/getMoviesByTitle', params={'title' : usermovie}).json()
		if len(bt_title) == 0:
			print("I'm sorry, that movie wasn't found.")
			return btRetrieval()
	
	if 'status' in bt_title:
		print('Status: ' + bt_title.get('status') + ', '+bt_title.get('description'))
		return btRetrieval()
	
	if not type(bt_title) == list:
		bt_title = [bt_title]
	
	for movie in bt_title:
		imdbid = 'tt'+movie.get('imdbid')
		omdb_title = requests.get('http://www.omdbapi.com/', params={'i':imdbid}).json()
		
		clean_movie = [
		("Title", omdb_title.get('Title')),
		("Year", omdb_title.get('Year')),
		("Bechdel Rating", movie.get('rating')),
		("Entered to BT Database on",movie.get('date')),
		("Entered to BT Database by", movie.get('submitterid')),
		("IMDb ID", omdb_title.get('imdbID')),
		("BT ID", movie.get('id')),
		("Rated", omdb_title.get('Rated')),
		("Runtime", omdb_title.get('Runtime')),
		("Genre", omdb_title.get('Genre')),
		("Director", omdb_title.get('Director')),
		("Writer", omdb_title.get('Writer')),
		("Actors", omdb_title.get('Actors')),
		("Plot", omdb_title.get('Plot')),
		("Language", omdb_title.get('Language')),
		("Country", omdb_title.get('Country')),
		("Awards", omdb_title.get('Awards')),
		("Poster", omdb_title.get('Poster')),
		("IMDb Rating", omdb_title.get('imdbRating')),
		("IMDb Votes", omdb_title.get('imdbVotes'))
		]
		
		print('\n')
		
		for kv in clean_movie:
			print(kv[0]+':\n  '+kv[1])
		
	btRetrieval()

btRetrieval()