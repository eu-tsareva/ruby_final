class Game
  ACCOUNT = 100
  BID_SIZE = 10
  MAX_SCORE = 21
  MOVES = {
    pass: 'Pass',
    take_card: 'Take card',
    open_cards: 'Show cards'
  }.freeze

  def initialize
    @view = View.new
    @name = @view.name
    @user = User.new(name: @name, account: ACCOUNT, bid_size: BID_SIZE)
    @dealer = Dealer.new(account: ACCOUNT, bid_size: BID_SIZE)
  end

  def start
    @deck = Deck.new
    @status = true
    @bank = 0
    players.each do |player|
      player.start_game(deck.deal_two)
      @bank += BID_SIZE
    end
    self.active = user
    view.print_greeting
  end

  def play
    view.print_info(players, bank)
    move = active.move(view)
    view.print_move(active, MOVES[move].downcase)
    make_move(move)
  end

  def on?
    status && moves_left?
  end

  def finish
    view.print_scores(players)
    divide_bank
  end

  def continuable?
    players.none?(&:broke?)
  end

  def replay?
    view.replay?(name)
  end

  def restart?
    view.restart?(name)
  end

  private

  attr_accessor :active, :status
  attr_reader :user, :dealer, :deck, :bank, :view, :name

  def players
    [user, dealer]
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
    view.print_winners(w_players, win)
    w_players.each { |winner| winner.win(win) }
  end

  def winners
    w_players = []
    user_score = user.score
    dealer_score = dealer.score
    w_players << dealer unless looser(dealer_score, user_score)
    w_players << user unless looser(user_score, dealer_score)
    w_players.empty? ? players : w_players
  end

  def looser(player_score, opponent_score)
    player_score > MAX_SCORE ||
      opponent_score.between?(player_score + 1, MAX_SCORE)
  end
end
