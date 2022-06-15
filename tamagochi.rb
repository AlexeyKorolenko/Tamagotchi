require_relative "game"
require_relative "animations"

class Tamagochi
  include Animations

  attr_accessor :name, :health, :eat, :fatigue, :mood, :age, :lifespan

  def initialize
    @name = "Jack"
    @health =  100 #здоровье
    @eat = 100 #сытость
    @fatigue = 100 #усталость
    @mood = 100 #настроение
    @age = 0 #возраст
    @lifespan = rand(2..30)
  end

  def stats
    puts "
         \nВаша статистика:
    Имя \t#{@name}
    Здоровье \t#{@health}
    Сытость \t#{@eat}
    Усталость \t#{@fatigue}
    Настроение \t#{@mood}
    Возраст \t#{@age} "
  end

  def pet_condition(name)
    if @health < 50
      puts "\n#{name} болеет!"
    elsif @eat < 50
      puts "\n#{name} хочет кушать!"
    elsif @fatigue < 50
      puts "\n#{name} хочет спать!"
    elsif @mood < 50
      puts "\n#{name} скучно!"
    end
  end

  def pet_death
    random_problems = ["от удара молнии.", "от падения в канаву.", "от яда.", "от смеха.", "прыгнув с 9-го этажа, так как думал что умеет летать."]

    if @health <= 0
      abort "#{name} умер от болезней в возрасте #{@age} лет.\n#{stats}"
    elsif @eat <= 0
      abort "#{name} умер от голода в возрасте #{@age} лет.\n#{stats}"
    elsif @fatigue <= 0
      abort "#{name} умер от недосыпа в возрасте #{@age} лет.\n#{stats}"
    elsif @mood <= 0
      abort "#{name} умер от скууууки в возрасте #{@age} лет.\n#{stats}"
    elsif @age == lifespan
      if lifespan >= 20
        abort "#{name} умер от старости в возрасте #{@age} лет."
      else
        abort "Ой! #{name} умер #{random_problems.sample}"
      end
    end
  end

  def live_status?
    return false if lifespan == @age
    @health > 0 && @eat > 0 && @fatigue > 0 && @mood > 0
  end
end
