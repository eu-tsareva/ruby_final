require_relative 'card.rb'
require_relative 'deck.rb'
require_relative 'player.rb'
require_relative 'user.rb'
require_relative 'dealer.rb'
require_relative 'view.rb'
require_relative 'game.rb'

loop do
  game = Game.new
  loop do
    game.start
    game.play while game.on?
    game.finish
    break unless game.continuable? && game.replay?
  end
  break if game.continuable? || !game.restart?
end
