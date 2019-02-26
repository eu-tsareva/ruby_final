class Dealer < Player
  def initialize(name: 'dealer', account:, bid_size:)
    super
  end

  def start_game(cards)
    self.moves = Game::MOVES.keys
    self.cards = cards
    bid
  end

  def choose_move
    return if cards.empty?

    move =
      if score >= 17
        moves.include?(:pass) ? :pass : :open_cards
      else
        :take_card
      end
    moves.delete(move)
  end

  def show_cards
    "\u2592 " * cards.size
  end
end
