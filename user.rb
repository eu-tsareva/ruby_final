class User < Player
  alias show_cards open_cards

  def start_game(cards)
    self.cards = cards
    self.moves = {}.merge Game::MOVES
    bid
  end

  def choose_move
    return if moves.empty? || cards.empty?

    puts "\nChoose your next move:"
    moves.values.each.with_index(1) { |val, i| puts "#{i}. #{val}" }
    move = moves.keys[gets.chomp.to_i - 1]
    moves.reject! { |k, _| k == move }
    move
  end
end
