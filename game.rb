require_relative "animations"

class Game
  include Animations

  attr_accessor :pet

  def initialize(pet)
    @pet = pet
  end

  def start
    difficulty = ask_level
    factor = difficulty_factor(difficulty)
    puts "Введите имя питомца:"
    pet.name = gets.chomp
    pet_stats

    while pet.live_status? do
      choice = action_game(pet.name)

      action(choice, factor)

      pet_stats
    end

    pet.pet_death
    pet.pet_stats
    exit
  end

  private

  def ask_level
    puts "Добро пожаловать в игру Тамагочи!"
    sleep 0.5
    puts "Выберите уровень сложности
    1. Легко
    2. Средне
    3. Сложно"
    difficulty = gets.chomp.to_i
    until difficulty.between?(1,3) do
      puts "Добро пожаловать в игру Тамагочи!"
      sleep 0.5
      puts "Выберите уровень сложности
      1. Легко
      2. Средне
      3. Сложно"
      difficulty = gets.chomp.to_i
    end
    difficulty
  end

  def difficulty_factor(difficulty)
    case difficulty
    when 1
      10
    when 2
      20
    when 3
      30
    else
      puts "error"
    end
  end

  def action_game(name)
    puts "\nЧто вы хотите сделать с #{name}?
  1. Полечить
  2. Покормить
  3. Поспать
  4. Поиграть
  5. Любить
  0. Ничего не делать"
    gets.chomp.to_i
  end

  def action(choice, factor)
    case choice
    when 1
      puts "Вы выбрали полечить #{pet.name}"
      pet.health = 100
      sleep 0.5
      puts "\n#{pet.name} лечится!"
      sleep 0.5
      healthing
      puts "\n#{pet.name} здоров!"
      sleep 0.5
      pet.eat -= rand(factor)
      pet.fatigue -= rand(factor)
      pet.mood -= rand(factor)
      pet.age += 1
    when 2
      puts "Вы выбрали покормить #{pet.name}"
      pet.eat = 100
      sleep 0.5
      puts "\n#{pet.name} кушает!"
      sleep 0.5
      eating
      puts "\n#{pet.name} покушал!"
      sleep 0.5
      pet.health -= rand(factor)
      pet.fatigue -= rand(factor)
      pet.mood += rand(30-factor)
      pet.age += 1
    when 3
      puts "Вы выбрали уложить спать #{pet.name}"
      pet.fatigue = 100
      sleep 0.5
      puts "\n#{pet.name} спит.."
      sleep 0.5
      sleeping
      puts "\n#{pet.name} проснулся!"
      sleep 0.5
      pet.health += rand(30-factor)
      pet.eat -= rand(factor)
      pet.mood -= rand(factor)
      pet.age += 1
    when 4
      puts "Вы выбрали поиграть с #{pet.name}"
      pet.mood = 100
      sleep 0.5
      puts "\n#{pet.name} играет!"
      sleep 0.5
      play
      puts "\n#{pet.name} поиграл!"
      sleep 0.5
      pet.health -= rand(factor)
      pet.eat -= rand(factor)
      pet.fatigue -=  rand(factor)
      pet.age += 1
    when 5
      puts "Вы любуетесь #{pet.name}"
      sleep 0.5
      love
      puts "#{pet.name} Вас любит ❤ ❤ ❤ "
      sleep 0.5
      pet.health -= rand(factor)
      pet.eat -= rand(factor)
      pet.fatigue -= rand(factor)
      pet.mood += rand(30-factor)
      pet.age += 1
    when 0
      puts "Вы выбрали ничего не делать"
      sleep 0.5
      pet.health -= rand(factor)
      pet.eat -= rand(factor)
      pet.fatigue -= rand(factor)
      pet.mood -= rand(factor)
      pet.age += 1
    else
      puts "Не правильно выбрано действие, попробуйте снова."
      stats
    end

  end

  def pet_stats
    pet.stats
  end
end