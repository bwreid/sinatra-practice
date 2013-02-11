create table mylist(
  id serial8 primary key,
  username varchar(12),
  pass varchar(18),
  first varchar(12),
  last varchar(24),
  task text,
  last_updated timestamp
)