# app.rb
require_relative 'lib/player'
require_relative 'lib/game'
require 'colorize'

def programm
# Créer une instance de Board avec les joueurs
puts "Souhaitez vous lancer une partie ? (oui/non)"
print "> "
partie = gets.chomp
while partie == "oui"
  # Créer les joueurs
  puts "Entrer le nom du joueur 1:".colorize(:color => :red)
  player_one = Player.create_player

  puts "Entrer le nom du joueur 2:".colorize(:color => :red)
  player_two = Player.create_player

  board = Game.new(player_one, player_two, 0)
  # Afficher les informations des joueurs (si nécessaire)
  puts "Joueur 1: #{board.user_one.name}"
  puts "Joueur 2: #{board.user_two.name}"
# Effectuer un coup et afficher le plateau
  board.choix_user
  board.display_board
  puts "souhaitez vous rejouer ?"
  
  partie = gets.chomp
end
end

programm




