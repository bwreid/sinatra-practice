create table frenemies(
  id serial8 primary key,
  first varchar(12) not null,
  last varchar(24) not null,
  identifier varchar(36) unique,
  age smallint,
  gender char(2),
  img_url varchar(200),
  twitter varchar(50),
  github varchar(100)
)