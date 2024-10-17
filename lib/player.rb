# lib/player.rb
class Player
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def self.create_player
    print "> "
    name_player = gets.chomp
    Player.new(name_player)
  end
end
