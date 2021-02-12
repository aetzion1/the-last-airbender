class AirbenderFacade
  class << self
    def get_characters
      data = CharacterService.search_by_nation(nation, limit)

      if data.is_a? Hash
        @characters = data.map do |character_info|
          Character.new(character_info)
        end
      else
        data
      end
    end
  end
end