require 'sinatra'
require 'sinatra/reloader'

  set :number, rand(100)
  @@guesses_remaining = 6

  get '/' do
    guess = params['guess'].to_i
    message, color = check_guess(guess)
    erb :index, :locals => {:number => settings.number,
                            :message => message,
                            :color => color,
                            :guesses_remaining => @@guesses_remaining}
  end

  def game_win
    @@guesses_remaining = 5
    settings.number = rand(100)
  end

  def game_lose
    @@guesses_remaining = 5
    settings.number = rand(100)
    message = "You lost! A new secret number has been generated."
  end

  def check_guess(guess)
    unless @@guesses_remaining == 1
      if guess.zero?
        message = "Please enter a valid guess..."
        color = "ffffff"
      elsif guess == settings.number
        message = "You won! The SECRET NUMBER was #{settings.number}. A new number has been generated."
        game_win
        color = "green"
      elsif guess > (settings.number + 5)
        @@guesses_remaining -= 1
        message = "Way too high!"
        color = "#FF0000"
      elsif guess > settings.number
        @@guesses_remaining -= 1
        message = "Too high!"
        color = "#FE8484"
      elsif guess < (settings.number - 5)
        @@guesses_remaining -= 1
        message = "Way too low!"
        color = "#FF0000"
      elsif guess < settings.number
        @@guesses_remaining -= 1
        message = "Too low!"
        color = "#FE8484"
      end
      return message, color
    end
    game_lose
  end
