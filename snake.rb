require_relative 'square'

class Snake
  attr_reader :size, :positions, :score
  attr_accessor :direction
  def initialize(size, x_start, y_start)
    @size = size
    @direction = 'right'
    @positions = [[2, 2], [2, 3], [2, 4]]
    @score = 0
    @growing = false
    @frequeny = 0
  end

  def head
    @positions.last
  end

  def grows
    @growing = true
  end

  def auto_move
    @frequeny += 1
    if @frequeny == 10
      @positions.shift unless @growing
      @positions.push(next_position)
      @growing = false
      @frequeny = 0
    end
  end

  def next_position
    case @direction
    when 'down' then circular_position(head[0], head[1] + 1)
    when 'up' then circular_position(head[0], head[1] - 1)
    when 'left' then circular_position(head[0] - 1, head[1])
    when 'right' then circular_position(head[0] + 1, head[1])
    end
  end

  def circular_position(x_pos, y_pos)
    [x_pos % @size, y_pos % @size]
  end

  def eat_food?(food)
    # return false if head[0] * @size > food.x_pos + food.size || food.x_pos > head[0] * @size + @size
    # return false if head[1] * @size > food.y_pos + food.size || food.y_pos > head[1] * @size + @size
    return false unless head[0] == food.x_pos && head[1] == food.y_pos

    grows
    @score += 1
    return true
  end

  def eat_itself?
    @positions.uniq.length != @positions.length
  end
end
