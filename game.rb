require 'gosu'
require_relative 'snake'
require_relative 'food'

class Game < Gosu::Window
  def initialize
    @snake = Snake.new(30, 50.0, 50.0)
    @screen_size = @snake.size**2
    @food = Food.new(rand(3..26), rand(3..26), false)

    @game_ended = false

    super(@screen_size, @screen_size)
    self.caption = "Snake game"

    @font = Gosu::Font.new(self, Gosu::default_font_name, 20)
  end

  def update
    unless @game_ended
      @snake.auto_move
      create_food
      check_lose_case
      control_keyboard
    end
  end

  def draw
    @snake.positions.each do |square|
      draw_rect(square[0] * @snake.size, square[1] * @snake.size, @snake.size, @snake.size, Gosu::Color::WHITE)
    end
    draw_rect(@snake.head[0] * @snake.size, @snake.head[1] * @snake.size, @snake.size, @snake.size, Gosu::Color::RED)
    draw_rect(@food.x_pos * @snake.size, @food.y_pos * @snake.size, @snake.size, @snake.size, Gosu::Color::GREEN)
    @font.draw("Your score: #{@snake.score}", 10, 10, 1, 1.0, 1.0, Gosu::Color::WHITE)
  end

  def button_down(id)
    if id == Gosu::KB_ESCAPE
      close
    else
      super
    end
  end

  def control_keyboard
    control_vertical
    control_horizontal
  end

  def control_vertical
    if @snake.direction == 'left' || @snake.direction == 'right'
      if Gosu.button_down? Gosu::KB_UP
        @snake.direction = 'up'
        # @snake.move(0, -2)
      end
      if Gosu.button_down? Gosu::KB_DOWN
        @snake.direction = 'down'
        # @snake.move(0, 2)
      end
    end
  end

  def control_horizontal
    if @snake.direction == 'up' || @snake.direction == 'down'
      if Gosu.button_down? Gosu::KB_LEFT
        @snake.direction = 'left'
        # @snake.move(-2, 0)
      end
      if Gosu.button_down? Gosu::KB_RIGHT
        @snake.direction = 'right'
        # @snake.move(2, 0)
      end
    end
  end

  def create_food
    @food.mark_eaten if @snake.eat_food?(@food)
    @food.new_position if @food.eaten?
  end

  def check_lose_case
    @game_ended = true if @snake.eat_itself?
  end
end

Game.new.show
