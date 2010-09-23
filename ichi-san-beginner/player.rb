class Player

  @@health = []
  @@current_health = 0
  @@pending_actions = []
  @@turn_count = 0

  attr_accessor :warrior

  def warrior=(warrior)
    @warrior = warrior
    @@turn_count += 1
    keep_health
  end

  def play_turn(warrior)
  
    self.warrior = warrior

    if !@@pending_actions.empty?
      do_pending_actions!
    elsif warrior.feel.wall?
      warrior.pivot!
    elsif warrior.feel.enemy?
      if @@current_health < 50
        scape_and_rest
      else 
        warrior.attack!
      end
    elsif warrior.feel.captive?
      warrior.rescue!
    else
      warrior.walk!
    end

  end

  private

  def do_pending_actions!
    instance_eval(@@pending_actions.pop)
  end  

  def scape_and_rest
    p "Scape and rest!"
    if under_attack?
      @warrior.walk! :backward
      @@pending_actions.push 'scape_and_rest'
    elsif below_health?
      @warrior.rest!
      @@pending_actions.push 'scape_and_rest'
    end
  end

  def below_health?
    @@current_health < 90
  end

  def under_attack?
    if @@turn_count == 1
      return false
    else
      @@health[-2] > @@health[-1]
    end
  end 

  def keep_health
    @@health << @warrior.health
    @@current_health = @warrior.health.quo(@@health.first) * 100
  end

end
