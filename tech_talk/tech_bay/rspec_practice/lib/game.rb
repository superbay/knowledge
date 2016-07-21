class Game

  COMBINATIONS = {
    'scissors' => 'paper',
    'rock'     => 'scissors',
    'paper'    => 'rock'
  }

  def call(first_move, second_move)
    if first_move == second_move
      'draw'
    elsif COMBINATIONS[first_move] === second_move
      "#{first_move} beats #{COMBINATIONS[first_move]}"
    else
      "#{second_move} beats #{COMBINATIONS[second_move] }"
    end
  end

  def get_user_input
    puts "Please select rock, paper or scissors"
    gets.chomp
  end

  def play
    puts call(get_user_input, rand_choice)
  end

  private

  def rand_choice
    COMBINATIONS.values.sample
  end
end
