class Game
  ACCOUNT = 30
  BID_SIZE = 10
  MAX_SCORE = 21
  MOVES = {
    pass: 'Pass',
    take_card: 'Take card',
    open_cards: 'Show cards'
  }.freeze

  def initialize(user_name)
    @user = User.new(name: user_name, account: ACCOUNT, bid_size: BID_SIZE)
    @dealer = Dealer.new(account: ACCOUNT, bid_size: BID_SIZE)
  end

  def start
    @deck = Deck.new
    @status = true
    @bank = 0
    [user, dealer].each do |player|
      player.start_game(deck.deal_two)
      @bank += BID_SIZE
    end
    self.active = user
  end

  def play
    print_info
    move = active.choose_move while move.nil?
    print_move move
    make_move move
  end

  def on?
    status && moves_left?
  end

  def finish
    print_scores
    divide_bank
  end

  def continue?
    [user, dealer].none?(&:broke?)
  end

  private

  attr_accessor :active, :status
  attr_reader :user, :dealer, :deck, :bank

  def print_info
    puts format('%20s', "bank: #{@bank}$")
    puts format('%-20s %-20s', user.info, dealer.info)
    puts format('%-20s %-20s', user.show_cards, dealer.show_cards)
  end

  def print_move(move)
    puts "#{active.name}'s move: #{MOVES[move].downcase}\n\n"
  end

  def print_scores
    puts format('%20s', 'Show cards!')
    puts format('%-20s %-20s', user.open_cards, dealer.open_cards)
    puts format('%-20s %-20s', user.score, dealer.score)
  end

  def print_winners(winners, win)
    puts '------------------------------'
    puts "Winner(s): #{winners.map(&:name).join(',')}"
    puts "The win is #{win}$"
    puts '------------------------------'
  end

  def make_move(move)
    case move
    when :pass
      switch_active
    when :take_card
      take_card
      switch_active
    when :open_cards
      self.status = false
    end
  end

  def switch_active
    self.active = active == dealer ? user : dealer
  end

  def take_card
    active.take_card(deck.deal_one)
  end

  def moves_left?
    active.moves? &&
      !(user.max_cards? && dealer.max_cards?)
  end

  def divide_bank
    w_players = winners
    win = bank / w_players.size
    print_winners(w_players, win)
    w_players.each { |winner| winner.win(win) }
  end

  def winners
    players = [user, dealer]
    user_score = user.score
    dealer_score = dealer.score
    return players if user_score == dealer_score

    players.delete(dealer) if looser(dealer_score, user_score)
    players.delete(user) if looser(user_score, dealer_score)
    players
  end

  def looser(player_score, opponent_score)
    player_score > MAX_SCORE ||
      opponent_score.between?(player_score + 1, MAX_SCORE)
  end
end
