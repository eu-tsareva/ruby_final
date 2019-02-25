class User < Player
  def initialize(name:, account:, bid_size:)
    super
    @moves = {
      pass: 'Pass',
      take_card: 'Take card',
      open_cards: 'Show cards'
    }
  end

  def choose_move
    return if moves.empty? || cards.empty?

    puts 'Choose your next move:'
    moves.values.each.with_index(1) { |val, i| puts "#{i}. #{val}" }
    move = moves.keys[gets.chomp.to_i - 1]
    choose_move if move.nil?
    moves.reject! { |k, _| k == move }
    move
  end
end

