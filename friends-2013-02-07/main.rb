require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_support/all'
require 'HTTParty'
require 'JSON'
require 'pg'
require_relative 'func'

get '/' do
  erb :home
end

get '/new' do
  erb :new
end

post '/create' do
  if params[:gender] == 'male'
    gender = 'ma'
  elsif params[:gender] == 'female'
    gender = 'fe'
  else
    gender = 'na'
  end

  @hash = { "first" => params[:first].capitalize, "last" => params[:last].capitalize,
           "identifier" => "#{params[:first].downcase}#{params[:last].downcase}", "age" => params[:age].to_i,
           "gender" => gender, "img_url" => params[:url], "twitter" => params[:twitter], "github" => params[:github] }
  @friend = "INSERT INTO frenemies (#{@hash.keys.join(", ")}) VALUES ('#{@hash.values.join("', '")}')"
  sql_query(@friend)
  redirect to('/friends')
end

get '/friends' do
  conn = PG.connect(:dbname =>'frenemies', :host => 'localhost')
  @var = conn.exec('select * from frenemies')
  conn.close
  erb :friends
end