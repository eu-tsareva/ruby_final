class Dealer < Player
  def initialize(name: 'dealer', account:, bid_size:)
    super
    @moves = %i[pass take_card open_cards]
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
end
