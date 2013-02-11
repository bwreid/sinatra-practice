require 'pry'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'yahoofinance'
require 'active_support/all' # ADDS A TON OF COOL STUFF FOR RAILS

get '/' do
  if params[:quote].present? # FROM ACTIVESUPPORT; DID SOMEONE TYPE SOMETHING IN THE BOX?
    @stock = params[:quote].upcase
    @quote = YahooFinance::get_quotes(YahooFinance::StandardQuote, "#{@stock}")["#{@stock}"].lastTrade
  end
  erb :quote
end
