require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'active_support/all'

get '/' do
  erb :home
end

post '/navigate' do
  page = params[:nav].downcase.to_sym
  redirect to("/#{page}")

  # case params[:nav].downcase
  # when 'politics' then redirect to('/politics')
  # end
end

get '/:name' do
  page = params[:name].to_sym
  erb page
end
