require 'colorize'

class TowersOfHanoi
  attr_reader :towers, :complete_tower

  def initialize(height = 3)
    @num_stacks = height
    @complete_tower = (1..height).to_a.reverse
    @towers = [complete_tower.dup, [], []]
  end

  def play
    display
    until won?
      begin
        p 'Move from, to:'
        from, to = get_move(gets.chomp)
      rescue ArgumentError => e
        puts e.message
        retry
      end
      next if illegal_move?(from, to)

      display
    end
  end

  def won?
    if towers.last == complete_tower
      puts 'You win!'
      true
    else
      false
    end
  end

  def get_move(input)
    input = input.split(",").map(&:strip).map(&:to_i)
    arr = [1, 2, 3]
    unless arr.include?(input[0]) && arr.include?(input[1])
      raise ArgumentError.new "invalid input"
    end

    input.map { |i| i - 1 }
  end

  def illegal_move?(from, to)
    if towers[from].empty?
      p 'Tower is empty'
      true
    elsif towers[to].empty? || towers[from].last < towers[to].last
      towers[to] << towers[from].pop
      false
    else
      p 'Illegal move'
      true
    end
  end

  def render
    (complete_tower.length - 1).downto(0).map do |height|
      towers.map do |stack|
        if stack[height].nil?
          "\u2551".center(2 * @num_stacks - 1).colorize(:blue)
        else
          multiplier = 2 * (stack[height]) - 1
          ("\u25A9" * multiplier).center(2 * @num_stacks - 1).colorize(:green)
        end
      end.join("  ")
    end.join("\n")
  end

  def display
    puts "\e[H\e[2J"
    puts display_poles("\u2551", " ", 2 * @num_stacks).colorize(:blue)
    puts display_poles("\u2551", " ", 2 * @num_stacks).colorize(:blue)
    puts render
    puts display_poles("\u2569", "\u2550", 2 * @num_stacks).colorize(:blue)
  end

  def display_poles(vchar, hchar, size)
    hchar * (size / 2 - 1) +
    vchar +
    hchar * size +
    vchar +
    hchar * size +
    vchar +
    hchar * (size / 2 - 1)
  end

end


game = TowersOfHanoi.new(3)
game.play
