class Food
  # Food represents food that snake will eat to score point and grows longer.
  attr_reader :x_pos, :y_pos
  def initialize(x_pos, y_pos, status)
    @x_pos = x_pos
    @y_pos = y_pos
    @status = status
  end

  def eaten?
    @status
  end

  def mark_eaten
    @status = true
  end

  def new_position
    @x_pos = rand(3..26)
    @y_pos = rand(3..26)
    @status = false
  end
end
