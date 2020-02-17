require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    word = params[:word]
    english_word?(word)
    if include?(word.upcase, params[:letters]) == false
      @result = "Sorry but #{word} can't be built out of #{params[:letters]} "
    elsif english_word?(word) == false
      @result = "Sorry but #{word} does not seem to be a valid English Word..."
    elsif include?(word.upcase, params[:letters]) && english_word?(word) == true
      @result = "Congraturations! #{word} is a valid English Word"
    end
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end

  def include?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end
end
