class SearchController < ApplicationController

  def index
    @characters = get_characters(nation)
  end

  private

  def conn
    Faraday.new(url: "https://last-airbender-api.herokuapp.com/api/v1")
  end

  def search_by_nation(nation)
    response = conn.get("/characters") do |req|
      req.params[:affiliation] = nation
    end

    if response.success?
        JSON.parse(response.body, symbolize_names: true)
    else
      'The avater api is having technical difficulties! Please try again later.'
    end
  end

  def get_characters(nation)
    data = nation_search(nation)

    if data.is_a? Hash
      @characters = data[:results].map do |character_info|
        Character.new(character_info)
      end
    else
      data
    end
  end



end