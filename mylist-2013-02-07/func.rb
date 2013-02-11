def new_task(user)
  a_task = params[:newtask]
  conn = PG.connect(:dbname =>'mylist', :host => 'localhost')
  new_list = conn.exec("SELECT task FROM lists WHERE username = '#{user}';").values[0][0].split("+*&").push(a_task.gsub("'","*&")).join("+*&")
  conn.exec("UPDATE lists SET task = '#{new_list}' WHERE username = '#{user}';")
  conn.close
end

def destroy_task(user)
  a_task = params[:destroy]
  conn = PG.connect(:dbname =>'mylist', :host => 'localhost')
  new_list = conn.exec("SELECT task FROM lists WHERE username = '#{user}';").values[0][0].split("+*&") # .push(a_task).join("+*&")
  new_list.delete(a_task.gsub("'","*&"))
  updated_list = new_list.join("+*&")
  conn.exec("UPDATE lists SET task = '#{updated_list}' WHERE username = '#{user}';")
  conn.close
end

def new(user)
  conn = PG.connect(:dbname =>'mylist', :host => 'localhost')
  conn.exec("INSERT INTO lists (username) VALUES user")
  conn.close
end

def check(user)
  conn = PG.connect(:dbname =>'mylist', :host => 'localhost')
  usernames = conn.exec("SELECT username FROM lists;")
  conn.close
  array = []
  array << user
  usernames.values.include?(array)
end