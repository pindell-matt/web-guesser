require 'sinatra'
require 'sinatra/reloader'

Number = rand(101)

def check_guess(guess)
  if guess.to_i > Number + 5
    "Way too high!"
  elsif guess.to_i > Number
    "Too high!"
  elsif guess.to_i < Number - 5
    "Way too low!"
  elsif guess.to_i < Number
    "Too low!"
  else
    "NAILED IT. The Secret Number is #{Number}"
  end
end

get '/' do
  guess = params["guess"]
  message = check_guess(guess.to_i)
  erb :index, :locals => {:number => Number,
                          :message => message
                         }
end
