class Snake
  # Snake allows user to traverse on screen to eat food and try to stay alive.
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

  # represent head of the snake
  def head
    @positions.last
  end

  def grows
    @growing = true
  end

  def auto_move
    @frequeny += 1 # decreases the speed of the snake.
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
    return false unless head[0] == food.x_pos && head[1] == food.y_pos

    grows
    @score += 1
    true
  end

  def eat_itself?
    @positions.uniq.length != @positions.length
  end
end
