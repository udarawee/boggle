class BoggleEvaluatorService
  attr_reader :board, :answers

  DIRECTIONS = [
    [-1, 0], [1, 0], [1, 1],
    [1, -1], [-1, -1], [-1, 1],
    [0, 1], [0, -1]
  ].freeze

  def initialize(board, answers)
    @board = board
    @answers = answers.map(&:upcase)
  end

  def score
    @score ||= valid_words.map(&:length).sum
  end

  def valid_words
    @valid_words ||= answers.select do |answer|
      answer.length > 1 &&
        exists_on_board?(answer) &&
        BoggleDictionary.exists?(answer)
    end
  end

  private
  def exists_on_board?(word)
    board.each_with_index do |row, row_num|
      row.each_with_index do |_letter, col_num|
        if found?(row_num, col_num, word)
          return true
        end
      end
    end
    return false
  end


  # based off of https://www.geeksforgeeks.org/search-a-word-in-a-2d-grid-of-characters/
  def found?(row, col, word)
    if board[row][col] != word[0]
      return false
    end

    DIRECTIONS.each do|x, y|
      rd, cd = row+x, col+y
      flag = true

      (1..word.length-1).each do |k|
        # if in bounds and curr letter matches continue
        in_bounds = (rd >= 0 && rd < num_rows) && (cd >= 0 && cd < num_columns)
        in_bounds_and_letters_match = in_bounds && word[k] == board[rd][cd]
        if in_bounds_and_letters_match
          rd+=x
          cd+=y
        else
          flag = false
          break
        end
      end

      if flag
        return true
      end
    end

    return false
  end

  def num_rows
    @num_rows ||= board.length
    end

  def num_columns
    @num_rows ||= board.length
  end
end
