class BoggleSolverService
  attr_reader :board

  def initialize(board)
    @board = board
    @valid_words = []
  end


  # from https://www.geeksforgeeks.org/boggle-find-possible-words-board-characters/
  def find_all_words
    # 2d array where every value is false
    visited_matrix = Array.new(num_rows){Array.new(num_columns, false)}

    current_str = ""
    # Consider every character and look for all words
    # starting with this character
    (0..num_rows-1).each do |x|
      (0..num_columns-1).each do |y|
        find_words(visited_matrix, x, y, current_str)
      end
    end
  end

  def find_words(visited_matrix, x, y, current_str)
    visited_matrix[x][y] = true
    current_str.concat(board[x][y])

    if (BoggleDictionary.exists?(current_str.downcase))
      valid_words << current_str
    end

    (i-1..num_rows-1).each do |row|
      if row <= x
        (j-1..num_columns-1).each do |column|
          if column <= y
            find_words(visited_matrix, row, column, current_str)
          else
            break
          end
        end
      else
        break
      end
    end

    # Erase current character from string and mark visited
    # of current cell as false
    current_str = current_str[0..-2]
    visited_matrix[x][y] = false

  end

  def num_rows
    @num_rows ||= board.length
  end

  def num_columns
    @num_rows ||= board.length
  end
end