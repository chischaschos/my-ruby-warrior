class Player

  ALL_DIRECTIONS = [:forward, :left, :right, :backward]

  def play_turn(warrior)
    valiant_move warrior
  end

  def valiant_move(warrior, directions = ALL_DIRECTIONS)
    directions.each do |direction|
      if warrior.feel(direction).enemy?
        warrior.attack!(direction)
      end
    end
  end

end
