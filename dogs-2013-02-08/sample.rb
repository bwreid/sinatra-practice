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
  # conn = PG.connect(:dbname =>'mylist', :host => 'localhost')
  # members_list = conn.exec("SELECT username FROM lists")
  # conn.close
  # array = []
  # members_list.each do |x|
  #   array << x["username"]
  # end
  check($username)

  if $username != ""
    conn = PG.connect(:dbname =>'mylist', :host => 'localhost')
    listed = conn.exec("select task from lists WHERE username = '#{$username}';")
    @tasks = listed.values[0][0].split("+*&")  # RETURNS AN ARRAY OF ALL TASKS
    conn.close
  # else
  #   conn = PG.connect(:dbname =>'mylist', :host => 'localhost')
  #   listed = conn.exec("INSERT INTO lists (username, task) VALUES ('#{$username}', 'my first task');")
  #   conn.close
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