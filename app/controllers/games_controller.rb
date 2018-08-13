require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    if session[:points].nil?
      session[:points] = 0
    end
    @letters = [*('A'..'Z'),*('A'..'Z')].sample(10)
  end

  def score
    @answer = params[:answer]
    @letters = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    user_serialized = open(url).read
    @result = JSON.parse(user_serialized)
    if @result["found"]
      @comp_ar = @answer.upcase.chars - @letters.chars
      if @comp_ar.length == 0
        @return = "Congratulation!!!"
        session[:points] += (@answer.length * 10)
      else
        @return = "Not in the grid"
      end
    else
      @return = "Not an english word"
    end
  end
end
