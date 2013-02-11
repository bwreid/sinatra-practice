def sql_query(sql)
  conn = PG.connect(:dbname =>'frenemies', :host => 'localhost')
  @this = conn.exec(sql)
  conn.close
  return @var
end