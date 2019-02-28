class User < Player
  alias show_cards open_cards

  private

  def choose_move(view)
    index = view.move(moves.values)
    moves.keys[index]
  end
end
