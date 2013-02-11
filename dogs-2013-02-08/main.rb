require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_support/all'
require 'HTTParty'
require 'JSON'
require 'pg'

before do # THIS HAPPENS BEFORE YOU GET TO ANY PAGE
  menu = "SELECT distinct breed FROM dogs ORDER BY breed ASC;"
  @nav_rows = sql_query(menu)
end

get '/' do
  erb :home
end

get '/new' do
  erb :new
end

get '/dogs' do
  my_dogs = "SELECT * FROM dogs ORDER BY name ASC"
  @rows = sql_query(my_dogs)
  erb :dogs
end

post '/create' do
  a_dog = "INSERT INTO dogs (name, photo, breed) VALUES ('#{params[:name]}','#{params[:photo]}','#{params[:breed].titleize}');"
  sql_query(a_dog)
  redirect to('/dogs')
end

get '/dogs/:breed' do
  my_dogs = "SELECT * FROM dogs WHERE breed = '#{params[:breed]}'"
  @rows = sql_query(my_dogs)
  erb :dogs
end

post '/dogs/:id' do
  update_dog = "UPDATE dogs SET name = '#{params['name'].capitalize}', photo = '#{params['photo']}', breed = '#{params['breed'].titleize}' WHERE id = #{params[:id]}"
  sql_query(update_dog)
  redirect to('/dogs')
end

get '/dogs/:id/edit' do
  edit_dog = "SELECT * FROM dogs WHERE id = #{params[:id]}"
  rows = sql_query(edit_dog)
  @row = rows.first
  erb :new
end

post '/dogs/:id/delete' do
  remove_dog = "DELETE FROM dogs WHERE id = #{params[:id]}"
  sql_query(remove_dog)
  redirect to('/dogs')
end

def sql_query(sql)
  conn = PG.connect(:dbname =>'dogs_db', :host => 'localhost')
  results = conn.exec(sql)
  conn.close
  results
end
