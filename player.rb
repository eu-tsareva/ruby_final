class Player
  attr_accessor :cards
  attr_reader :name

  def initialize(name:, account:, bid_size:)
    @name = name
    @account = account
    @bid_size = bid_size
    @cards = []
  end

  def info
    "#{name} (#{@account}$)"
  end

  def bid
    self.account -= bid_size
  end

  def win(money)
    self.account += money
  end

  def take_card(card)
    cards << card
  end

  def score
    sum = cards.sum(&:value)
    cards.none?(&:ace?) || sum > 11 ? sum : sum + 10
  end

  protected

  attr_accessor :account
  attr_reader :bid_size, :moves
end
