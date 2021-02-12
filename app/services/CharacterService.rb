class CharacterService
  class << self

    def search_by_nation(nation, limit)    
      response = conn.get("/characters") do |req|
        req.params[:affiliation] = nation
        req.params[:perPage] = limit
      end

      if response.success?
        character_data = JSON.parse(response.body, symbolize_names: true)
      else
        'The avater api is having technical difficulties! Please try again later.'
      end

      @characters = character_data.map do |character_info|
        Character.new(character_info)
      end
    end

    private

    def conn
      Faraday.new(url: "https://last-airbender-api.herokuapp.com/api/v1")
    end

  end
end
