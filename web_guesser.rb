require 'sinatra'
require 'sinatra/reloader'

@@secret_number = rand(100)
@@guess_count   = 5

def check_guess(guess)
  guess = guess.to_i
  unless guess == @@secret_number
    guess > @@secret_number ? high_guess(guess) : low_guess(guess)
  else
    congrats_message
  end
end

def cheat_mode?
  params["cheat"] == 'true'
end

def win?(message)
  message == congrats_message
end

def show_secret?(message)
  "The SECRET NUMBER is #{@@secret_number}" if win?(message) || cheat_mode?
end

def congrats_message
  "You got it right!"
end

def low_guess(guess)
  guess < (@@secret_number - 5) ? "Way Too Low!" : "Too Low!"
end

def high_guess(guess)
  guess > (@@secret_number + 5) ? "Way Too High!" : "Too High!"
end

def color_match(message)
  if win?(message)
    "#3EC5A0"
  else
    message.include?("Way") ? "#E63838" : "#FF6666"
  end
end

def new_game
  @@secret_number = rand(100)
  @@guess_count   = 5
end

def check_game_status(message)
  @@guess_count -= 1
  if @@guess_count == 0
    new_game
    message = "You Failed! A New SECRET NUMBER has been generated."
  elsif win?(message)
    new_game
    message
  else
    message
  end
end

get '/' do
  guess      = params["guess"]
  submitted  = check_guess(guess)
  background = color_match(submitted)
  secret     = show_secret?(submitted)
  message    = check_game_status(submitted)
  erb :index, locals: {
                        message: message,
                        secret: secret,
                        background: background
                      }
end
