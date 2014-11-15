require 'open-uri'  #Requires open uri to import the British dictionary
#Start patching the string class:
class String
  def colorize(color_code)
    "\e[#{color_code}m#{self}\e[0m" #ANSI sequence that colours text.
  end

  #All base colours:

  def red
    colorize(31)
  end

  def green
    colorize(32)
  end

  def yellow
    colorize(33)
  end

  def blue
    colorize(34)
  end

  def pink
    colorize(35)
  end

  def rainbow
    colorize(rand(5) + 31)
  end

  def super_rainbow
    #Use String.each_char next time.
    str = self.split('')
    colstr = []
    str.each do |letter|
      colstr.push(letter.rainbow)
    end
    colstr.join
  end
end
#Stop Patching the String class.
#Start Creating Custom Modules:
module Screen
  def self.clear
    system 'clear' or system 'cls'  #This both runs clear, and cls, so it is compatible in windows, mac, and Linux
  end
end
#Stop Creating Custom Modules
#Begin The User Methods:
def draw_man(draw_num)
  parts = ["\n |       @", "\n |      /", '|', "\\", "\n |       |", "\n |      / ", "\\"]
  empty, front, back = "\n |       ", "____________\n |       |", "\n |\n-------------"
  return front + empty * 4 + back                     if draw_num == 0
  return front + parts[0] + empty * 3 + back          if draw_num == 1
  return front + parts[0..1].join + empty * 2 + back  if draw_num == 2
  return front + parts[0..2].join + empty * 2 + back  if draw_num == 3
  return front + parts[0..3].join + empty * 2 + back  if draw_num == 4
  return front + parts[0..4].join + empty * 1 + back  if draw_num == 5
  return front + parts[0..5].join + back              if draw_num == 6
  return front + parts[0..6].join + back              if draw_num == 7
end

def check_letter(win_word, letter)
  (0..win_word.split('').count).to_a.select {|i| win_word[i] == letter}.join()  #Need to join twice, because multiple adjacent letter positions cause errors.
  #return the the indexes of the win_word in an array after running the enumerable select on it and checking the existence of a letter and joining the array.
end

def display_result(win_word, letters_guessed)
  lttr_indx = Array.new #Create a new array that will contain the correct letters index
  letters_guessed.each { |letter| lttr_indx << check_letter(win_word, letter) } #for each letter, append check letter with parameters win_word and letter onto crrLttr array.
  lttr_indx.join.each_char.map(&:to_i).each_with_object([?_]*win_word.length) { |i,arr| arr[i] = win_word.split('')[i] }
  #take the string, join it into an array, create the enumerable object each char, map that enumerable object with the parameters (&:to_i) which turns everything into an integer.
  #Then, run.each with the object, with the parameters of [?_] multiplied by the length of the word. This effectively creates an array with only underscores.
  #Then, run an iterator which contains the index of the array, and the array itself.
  #Then, use this iterator to set the passed object with the index i at that location equal to the win_word converted to an array with i at that location.
end

def import_dict
  puts 'WARNING: This will take a few seconds'.yellow
  words = []
  open('http://www.mieliestronk.com/corncob_lowercase.txt') do |f|  #This is were there is a word list of the entire British dictionary
    f.each_line do |l|
      words.push(l.strip)
    end
  end
  words.shuffle
end

def create_alph
  %w(a b c d e f g h i j k l m n o p q r s t u v w x y z)
end
#End User Methods
#Start Main Program
Screen.clear  #Clear screen to get rid of previous commands.
puts 'Importing dictionary'.green
dict = import_dict
puts 'Dictionary Imported!'.green
puts 'You can play BRITISH HANGMAN with this program'.green
puts 'To quit at any time type: quit'.green

for i in 0..dict.count #This creates a system that will choose a new word every game.  #TODO: Do .each
  alphabet, wrong_guesses, letters_guessed, win_word = create_alph, 0, [], dict[i]
  puts "\u2588\u2588\u2557  \u2588\u2588\u2557 \u2588\u2588\u2588\u2588\u2588\u2557 \u2588\u2588\u2588\u2557   \u2588\u2588\u2557 \u2588\u2588\u2588\u2588\u2588\u2588\u2557 \u2588\u2588\u2588\u2557   \u2588\u2588\u2588\u2557 \u2588\u2588\u2588\u2588\u2588\u2557 \u2588\u2588\u2588\u2557   \u2588\u2588\u2557\r\n\u2588\u2588\u2551  \u2588\u2588\u2551\u2588\u2588\u2554\u2550\u2550\u2588\u2588\u2557\u2588\u2588\u2588\u2588\u2557  \u2588\u2588\u2551\u2588\u2588\u2554\u2550\u2550\u2550\u2550\u255D \u2588\u2588\u2588\u2588\u2557 \u2588\u2588\u2588\u2588\u2551\u2588\u2588\u2554\u2550\u2550\u2588\u2588\u2557\u2588\u2588\u2588\u2588\u2557  \u2588\u2588\u2551\r\n\u2588\u2588\u2588\u2588\u2588\u2588\u2588\u2551\u2588\u2588\u2588\u2588\u2588\u2588\u2588\u2551\u2588\u2588\u2554\u2588\u2588\u2557 \u2588\u2588\u2551\u2588\u2588\u2551  \u2588\u2588\u2588\u2557\u2588\u2588\u2554\u2588\u2588\u2588\u2588\u2554\u2588\u2588\u2551\u2588\u2588\u2588\u2588\u2588\u2588\u2588\u2551\u2588\u2588\u2554\u2588\u2588\u2557 \u2588\u2588\u2551\r\n\u2588\u2588\u2554\u2550\u2550\u2588\u2588\u2551\u2588\u2588\u2554\u2550\u2550\u2588\u2588\u2551\u2588\u2588\u2551\u255A\u2588\u2588\u2557\u2588\u2588\u2551\u2588\u2588\u2551   \u2588\u2588\u2551\u2588\u2588\u2551\u255A\u2588\u2588\u2554\u255D\u2588\u2588\u2551\u2588\u2588\u2554\u2550\u2550\u2588\u2588\u2551\u2588\u2588\u2551\u255A\u2588\u2588\u2557\u2588\u2588\u2551\r\n\u2588\u2588\u2551  \u2588\u2588\u2551\u2588\u2588\u2551  \u2588\u2588\u2551\u2588\u2588\u2551 \u255A\u2588\u2588\u2588\u2588\u2551\u255A\u2588\u2588\u2588\u2588\u2588\u2588\u2554\u255D\u2588\u2588\u2551 \u255A\u2550\u255D \u2588\u2588\u2551\u2588\u2588\u2551  \u2588\u2588\u2551\u2588\u2588\u2551 \u255A\u2588\u2588\u2588\u2588\u2551\r\n\u255A\u2550\u255D  \u255A\u2550\u255D\u255A\u2550\u255D  \u255A\u2550\u255D\u255A\u2550\u255D  \u255A\u2550\u2550\u2550\u255D \u255A\u2550\u2550\u2550\u2550\u2550\u255D \u255A\u2550\u255D     \u255A\u2550\u255D\u255A\u2550\u255D  \u255A\u2550\u255D\u255A\u2550\u255D  \u255A\u2550\u2550\u2550\u255D\r\n                                                                ".super_rainbow
  #This is Unicode for the HANGMAN banner
  sleep 4 #Sleep so people can enjoy the banner
  while true  #loop for a single turn
    Screen.clear
    puts draw_man(wrong_guesses)
    break if wrong_guesses == 7 || !display_result(win_word, letters_guessed).join('').include?('_') #TODO: display result does not include underscores
    puts 'Guess this word: ' << display_result(win_word, letters_guessed).join(' ')
    puts 'Guessed letters: ' << letters_guessed.sort.join(' ')
    print 'Guess a letter: '
    user_guess = gets.chomp
    exit if user_guess == 'quit'
    next unless alphabet.include?(user_guess)
    letters_guessed << user_guess
    wrong_guesses += 1 if check_letter(win_word, user_guess) == ''
  end
  if wrong_guesses == 7
    puts 'You Lose!'.red
  else
    puts 'YOU WIN'.super_rainbow
  end
  puts "The Word: #{win_word}"
  puts 'Remember! This is: '.green << ' BRITISH HANGMAN'.super_rainbow
  puts 'Play Again? (y/n)'.yellow
  exit unless gets.chomp == 'y'
  Screen.clear
end