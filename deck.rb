class Deck
  def initialize
    @cards = []
    generate
  end

  def deal_two
    cards.pop(2)
  end

  def deal_one
    cards.pop
  end

  private

  attr_reader :cards

  def generate
    Card::SUITS.each do |suit|
      Card::RANKS.each do |rank|
        cards << Card.new(suit: suit, rank: rank)
      end
    end
    cards.shuffle!
  end
end
