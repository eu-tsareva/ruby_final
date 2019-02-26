require_relative 'card.rb'
require_relative 'deck.rb'
require_relative 'player.rb'
require_relative 'user.rb'
require_relative 'dealer.rb'
require_relative 'game.rb'

print 'Type your name: '
name = gets.chomp
loop do
  game = Game.new(name)
  loop do
    puts "Game on!\n"
    game.start
    game.play while game.on?
    game.finish
    break unless game.continue?

    puts "#{name}, would you like to play again? (print 'no' to exit)"
    break if gets.chomp == 'no'
  end
  break if game.continue?

  puts 'One of the players has no money'
  puts "#{name}, would you like to restart? (print 'no' to exit)"
  break if gets.chomp == 'no'
end
