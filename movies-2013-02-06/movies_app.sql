create table movies(
  id serial8 primary key,
  title varchar(250),
  year varchar(10),
  rated varchar(10),
  released varchar(20),
  runtime varchar(20),
  genre text,
  director text,
  writer text,
  actors text,
  plot text,
  poster text,
  imdbRating varchar(20),
  imdbvotes varchar(20),
  imdbid text,
  response varchar(10),
  favorited boolean default false
)