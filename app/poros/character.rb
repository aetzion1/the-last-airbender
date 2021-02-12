class Character
  attr_reader :name, :photoUrl, :allies, :enemies, :affiliation

  def initialize(data)
    @name = data[:name]
    @photoUrl = data[:photoUrl]
    @allies = data[:allies]
    @enemies = data[:enemies]
    @affiliation = data[:affiliation]
  end
end