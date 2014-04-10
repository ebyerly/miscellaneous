library(RPostgreSQL)

# define driver
drv <- dbDriver('PostgreSQL')

# define connection
medicare_conn <- dbConnect(drv, user='postgres',password='****',dbname='medicare2012',host='localhost',port='5432')

# example query
query <- dbSendQuery(medicare_conn, 'SELECT * FROM medicare_original limit 10')

# Extracting from query
example_dataframe <- fetch(rs)