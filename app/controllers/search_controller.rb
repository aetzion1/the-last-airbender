class SearchController < ApplicationController
  def index
    session[:nation] = params[:nation].gsub("_", "+")
    @nation = params[:nation].gsub("_", " ").titleize

    response = Faraday.get("https://last-airbender-api.herokuapp.com/api/v1/characters?affiliation=#{nation}&perPage=100")
    if response.success?
      character_data = JSON.parse(response.body, symbolize_names: true)
    else
      'The avater api is having technical difficulties! Please try again later.'
    end
    @characters = character_data.map do |character_info|
      Character.new(character_info)
    end

    # @characters = AirbenderService.search_by_nation(session[:nation])
  end
end