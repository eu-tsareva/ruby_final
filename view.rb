class View
  def name
    print 'Type your name: '
    gets.chomp
  end

  def move(moves)
    print_moves moves
    index = move_index while index.nil? || moves[index].nil?
    index
  end

  def replay?(name)
    puts "#{name}, would you like to play again? (print 'no' to exit)"
    gets.chomp != 'no'
  end

  def restart?(name)
    puts 'One of the players has no money'
    puts "#{name}, would you like to restart? (print 'no' to exit)"
    gets.chomp != 'no'
  end

  def print_greeting
    puts "Game on!\n"
  end

  def print_info(players, bank)
    puts format('%20s', "bank: #{bank}$")
    puts format('%-20s' * players.size, *players.map(&:info))
    puts format('%-20s' * players.size, *players.map(&:show_cards))
  end

  def print_move(player, move)
    puts "#{player.name}'s move: #{move}\n\n"
  end

  def print_scores(players)
    puts format('%20s', 'Show cards!')
    puts format('%-20s' * players.size, *players.map(&:open_cards))
    puts format('%-20s' * players.size, *players.map(&:score))
  end

  def print_winners(winners, win)
    puts '------------------------------'
    puts "Winner(s): #{winners.map(&:name).join(', ')}"
    puts "The win is #{win}$"
    puts '------------------------------'
  end

  private

  def print_moves(moves)
    puts "\nPossible moves:"
    moves.each.with_index(1) { |val, i| puts "#{i}. #{val}" }
  end

  def move_index
    gets.chomp.to_i - 1
  end
end
