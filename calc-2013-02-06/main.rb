require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development? # ALLOWS YOU TO CHANGE YOUR CODE AND SEE IT

# ==================================
# CREATING PAGES IN SINATRA
# ==================================

# CREATE A publics AND views FOLDER.
# >> public IS FOR CSS, IMAGES, AND JS
# >> views IS FOR YOUR HTML FILES (.erb)

# get '/' do
#   'I am the homepage.'
# end

# get '/hello' do
#   'i am a master hacker!'
# end

# name = 'bryan'

# get '/:name' do # NOW IT GOES DIRECTLY TO THE NAME
#   "Hey there #{params[:name]}. You've got it together." # SO COOL! PARAMS TAKES FROM THE URL
# end

# get "multiply/:x/:y" do
#   "your answer is : #{(params[:x].to_f * params[:y].to_f).round(2)}" # EVERYTHING IN PARAMS COMES BACK AS A STRING
# end

get "/:sym/:x/:y" do
  @result = (params[:x].to_f * params[:y].to_f).round(2) if params[:sym] == 'multiply'
  @result = (params[:x].to_f + params[:y].to_f).round(2) if params[:sym] == 'add'
  @result = (params[:x].to_f - params[:y].to_f).round(2) if params[:sym] == 'subtract'
  @result = (params[:x].to_f / params[:y].to_f).round(2) if params[:sym] == 'divide'
  erb :calc # CALLS THE calc.erb PAGE WE MADE
end

# get "/add/:x/:y" do
#   @result = (params[:x].to_f + params[:y].to_f).round(2)
#   erb :calc
# end

get "/calc" do
  @first = params[:first].to_f
  @second = params[:second].to_f
  @operator = params[:operator]

  @result = case params[:operator]
  when '+' then @first + @second
  when '-' then @first - @second
  when '*' then @first * @second
  when '/' then @first / @second
  end

  erb :calc
end
