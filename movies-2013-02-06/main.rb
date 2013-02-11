require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_support/all'
require 'HTTParty'
require 'JSON'
require 'pg'

get '/' do
  erb :home
end

post '/search' do
  data = params[:movie].split.join('+')
  url_get = HTTParty.get("http://www.omdbapi.com/?t=#{data}")
  movie = JSON(url_get.body.gsub("'",""))

  # CONNECTS TO DATABASE AND STORES BASIC INFORMATION
  conn = PG.connect(:dbname =>'movies_app', :host => 'localhost')

  listed = conn.exec('select title from movies')
  db_array_titles = []
  listed.each { |x| db_array_titles << x["title"] }

  if (movie["Title"].present?) && (db_array_titles.index(movie["Title"]) == nil)
    sql = "insert into movies (#{movie.keys.join(", ")}) values ('#{movie.values.join("', '")}')"
    conn.exec(sql)
  end

  conn.close

  string = ""
  @poster = movie["Poster"]
  movie.keys.each do |mov|
    if (mov != "Poster") && (mov != "Response") && (mov != "imdbRating") && (mov != "imdbVotes") && (mov != "imdbID")
      string += "<div class='movie'><p><strong>#{mov}:</strong> #{movie[mov]}</p></div>"
    end
  end
  @movie = string # "#{movie.keys.join(", ")} #{movie.values.join("', '")}"
  erb :home
end

get '/movies' do
  conn = PG.connect(:dbname =>'movies_app', :host => 'localhost')
  listed = conn.exec('select poster from movies')
  @poster = []
  listed.each { |x| @poster << x["poster"] }
  erb :movies
end
