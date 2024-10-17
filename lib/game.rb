require 'colorize'
class Game
  attr_accessor :plateau, :user_one, :user_two
  
  def initialize(user_one, user_two, nb_coup)
    @plateau = [
      [" ", "1", "2", "3"],
      ["A", " ", " ", " "],
      ["B", " ", " ", " "],
      ["C", " ", " ", " "]
    ]
    @user_one = user_one
    @user_two = user_two
    @nb_coup = nb_coup
  end


  def choix_user
    @@current = user_one #fait commencer le joueur un 
    vainqueur = false
    display_board
    while @nb_coup != 9 #boucle qui tourne tant que les 9 coup ne sont pas jouer
      puts ("#{@@current.name}, rentrer un coup (ex: a1, b2, c3) :").colorize(:color => :red)
      print "> "
      choix = gets.chomp

    
      chiffre = {
        "a" => 1,
        "b" => 2,
        "c" => 3
      }
      
      #verifie si lentrer et de 2 caractere ET si la lettre et dans le hash chiffre ET si le chiffre et compris entre 1 et 3
      if choix.length == 2 && chiffre.key?(choix[0].downcase) && choix[1].to_i.between?(1, 3)
        ligne = chiffre[choix[0].downcase]
        colonne = choix[1].to_i
    
        #Verifie si la case et libre
        if @plateau[ligne][colonne] == " "
          @plateau[ligne][colonne] = (@@current == user_one ? "X" : "O")  # Mettre "X" ou "O"
          @nb_coup += 1
    
          display_board  # affiche le plateau

          if verif_horizontal || verif_vertical || verif_diagonal_une || verif_diagonal_deux
            vainqueur = true
            break       
          end

          # Changer de joueur
          @@current = (@@current == user_one ? user_two : user_one)
        else
          puts "Case déjà prise "
        end
      else
        puts "Entrer Invalide merci de rentrer une lettre de A a C et un chiffre de 1 a 3"
      end
     
    end
     # Si la boucle se termine et qu'aucun gagnant n'a été trouvé
  if @nb_coup == 9 && !vainqueur
    puts "Match nul !"  # Afficher le message de match nul
  elsif vainqueur
    puts ("Félicitations au gagnant !").colorize(:color => :green)
  end
  end




  def verif_horizontal
    # Parcours les 3 lignes de A à C
    (1..3).each do |ligne|
      ["O", "X"].each do |symbole|
        # verifie uniquement les colonnes 1 à 3 pour chaque ligne (ignorer les index 0)
        if @plateau[ligne][1..3].all? { |case_remplie| case_remplie == symbole }
          puts "#{@@current.name} a rempli la ligne #{ligne} avec '#{symbole}'"
          return true
        end
      end
   end
    false # Si aucune colonne n'est remplie, retourne false
  end

  def verif_vertical
    (1..3).each do |colonne| 
      ["O", "X"].each do |symbole| # verification pour les deux symbole
        if @plateau[1][colonne] == symbole && @plateau[2][colonne] == symbole && @plateau[3][colonne] == symbole
          puts "#{@@current.name} a rempli la colonne #{colonne} avec '#{symbole}'"
          return true
        end
      end
    end
    false 
  end
  
  def verif_diagonal_une
    if @plateau[1][1] == "X" && @plateau[2][2] == "X" && @plateau[3][3] == "X"
      puts "#{@@current.name} a rempli la diagonale avec 'X'"
      return true
     
    elsif @plateau[1][1] == "O" && @plateau[2][2] == "O" && @plateau[3][3] == "O"
      puts "#{@@current.name} a rempli la diagonale avec 'O'"
      return true
    end
  end

  def verif_diagonal_deux
    if @plateau[1][3] == "X" && @plateau[2][2] == "X" && @plateau[3][1] == "X"
      puts "#{@@current.name} a rempli la diagonale avec 'X'"
      return true
    elsif @plateau[1][3] == "O" && @plateau[2][2] == "O" && @plateau[3][1] == "O"
      puts "#{@@current.name} a rempli la diagonale avec 'O'"
      return true
    end
  end
  


  



  def display_board
    @plateau.each do |casetab|
      puts casetab.join(" | ").colorize(:color => :blue)
      puts ("-" * 14).colorize(:color => :blue)
    end
  end
end

