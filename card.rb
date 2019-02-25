class Card
  RANKS = (2..10).to_a + %w[J Q K A]
  SUITS = ["\u2666", "\u2665", "\u2663", "\u2660"]

  attr_reader :suit, :rank

  def initialize(suit:, rank:)
    @suit = suit
    @rank = rank
  end

  def value
    return rank if rank.is_a?(Integer)

    rank == 'A' ? 1 : 10
  end

  def to_s
    "#{rank}#{suit}"
  end
end
