class Dealer < Player
  def initialize(name: 'dealer', account:, bid_size:)
    super
  end

  def show_cards
    "\u2592 " * cards.size
  end

  private

  def choose_move(_view)
    if score >= 17
      moves.key?(:pass) ? :pass : :open_cards
    else
      :take_card
    end
  end
end
