require_relative 'card.rb'
require_relative 'deck.rb'

deck = Deck.new
cards = deck.deal_two
puts cards
cards = deck.deal_one
puts cards

