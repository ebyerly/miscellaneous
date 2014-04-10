library(RPostgreSQL)

# define driver
drv <- dbDriver('PostgreSQL')

# define connection
medicare_conn <- dbConnect(drv, user='postgres',password='****',dbname='medicare2012',host='localhost',port='5432')

# Example query (returns a result set object, or gibberish for our purposes)
query <- dbSendQuery(medicare_conn, 'SELECT * FROM medicare_original limit 10')

# Extracting from query (converts the RSO into a dataframe)
example_dataframe <- fetch(query)

# Performs dbSendQuery, fetch, and dbClearResult functions in one.
dbGetQuery(medicare_conn, 'Select * from medicare_original limit 5')