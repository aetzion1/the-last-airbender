class SearchController < ApplicationController

  def index
    session[:nation] = params[:nation].gsub("_", "+")
    response = Faraday.get("https://last-airbender-api.herokuapp.com/api/v1/characters?affiliation=#{session[:nation]}")
    data = JSON.parse(response.body, symbolize_names: true)
    @characters = data[:results].map do |character_info|
      Character.new(character_info)
    end
    # @characters = get_characters(session[:nation])
  end

  private

  def conn
    Faraday.new(url: "https://last-airbender-api.herokuapp.com/api/v1")
  end

  def search_by_nation(nation)
    require 'pry'; binding.pry
    response = conn.get('/characters?affiliation=#{nation}') #do |req|
      # req.params[:affiliation] = nation
    # end
    require 'pry'; binding.pry
    if response.success?
        JSON.parse(response.body, symbolize_names: true)
    else
      'The avater api is having technical difficulties! Please try again later.'
    end
  end

  def get_characters(nation)
    data = search_by_nation(nation)

    if data.is_a? Hash
      @characters = data[:results].map do |character_info|
        Character.new(character_info)
      end
    else
      data
    end
  end



end