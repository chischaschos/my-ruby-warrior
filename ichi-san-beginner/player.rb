class Player
  def play_turn(warrior)
    @warrior = warrior
    @look = warrior.look

    if incoming_enemy?
      warrior.shoot!

    elsif warrior.feel.wall?
      warrior.pivot!

    elsif below_health_threshold?
      if !under_attack?
        warrior.rest!

      elsif under_attack?
        if see_nobody?
          warrior.walk! :backward

        elsif warrior.feel.captive?
          warrior.rescue!

        else
          warrior.attack!

        end
      end
    elsif see_nobody?
      warrior.walk!

    elsif warrior.feel.captive?
      warrior.rescue!

    else
      warrior.attack!

    end

    @health = warrior.health
  end

  private
  def incoming_enemy?
    @look[1].enemy? && !@look[0].captive?
  end

  def suffering?
    under_attack? || below_health_threshold?
  end

  def below_health_threshold?
    @warrior.health < 18
  end

  def under_attack?
    @warrior.health < (@health || 0)
  end

  def safe?
    !under_attack? && see_nobody?
  end

  def see_nobody?
    @warrior.feel.empty?
  end
end
