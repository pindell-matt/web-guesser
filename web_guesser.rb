require 'sinatra'

get '/' do
  random = rand(0..100)
  "The secret number is #{random}"
end
