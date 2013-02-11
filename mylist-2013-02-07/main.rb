require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_support/all'
require 'HTTParty'
require 'JSON'
require 'pg'
require_relative 'func.rb'


$username = ""

get '/' do
  if check($username)
    conn = PG.connect(:dbname =>'mylist', :host => 'localhost')
    listed = conn.exec("select task from lists WHERE username = '#{$username}';")
    @count = listed.values[0][0].split("+*&").length
    @tasks = listed.values[0][0].split("+*&")  # RETURNS AN ARRAY OF ALL TASKS
    conn.close
  elsif $username != ""
    conn = PG.connect(:dbname =>'mylist', :host => 'localhost')
    conn.exec("INSERT INTO lists (username, task) VALUES ('#{$username}', 'Your first task!');")
    conn.close
  else
  end

  erb :home
end

get '/new' do
  erb :new
end

post '/create' do
  new_task($username)
  redirect to('/')
end

post '/destroy' do
  destroy_task($username)
  redirect to('/')
end

post '/login' do
  this = params[:user].downcase
  $username = this
  redirect to('/')
end

get '/logout' do
  $username = ""
  redirect to('/')
end