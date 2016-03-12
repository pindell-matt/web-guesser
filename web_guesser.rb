require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)

def check_guess(guess)
  guess = guess.to_i
  unless guess == SECRET_NUMBER
    guess > SECRET_NUMBER ? high_guess(guess) : low_guess(guess)
  else
    congrats_message
  end
end

def cheat_mode_activated?
  params["cheat"]
end

def win?(message)
  message == congrats_message
end

def show_secret?(message)
  if win?(message) || cheat_mode_activated?
    "The SECRET NUMBER is #{SECRET_NUMBER}"
  end
end

def congrats_message
  "You got it right!"
end

def low_guess(guess)
  guess < (SECRET_NUMBER - 5) ? "Way Too Low!" : "Too Low!"
end

def high_guess(guess)
  guess > (SECRET_NUMBER + 5) ? "Way Too High!" : "Too High!"
end

def color_match(message)
  unless win?(message)
    message.include?("Way") ? "#E63838" : "#FF6666"
  else
    "#3EC5A0"
  end
end

get '/' do
  guess      = params["guess"]
  message    = check_guess(guess)
  background = color_match(message)
  secret     = show_secret?(message)
  erb :index, locals: {
                        message: message,
                        secret: secret,
                        background: background
                      }
end
