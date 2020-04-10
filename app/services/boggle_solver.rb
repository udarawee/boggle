class BoggleSolver
  attr_reader :board, :valid_words
  DIRECTIONS = [
    [-1, -1], [0, -1], [1, -1],
    [-1, 0],          [1, 0],
    [-1, -1], [0, 1], [1, 1]
  ].freeze

  def initialize(board)
    @board = board
    @valid_words = []
  end


  def find_all_words
    # 2d array where every value is false
    all_words = []
    # Consider every character and look for all words starting with this character
    (0..num_rows-1).each do |y|
      (0..num_columns-1).each do |x|
        visited = [[y,x]]
        all_words += find_words(board[y][x], y, x, visited)
      end
    end
    all_words
  end
  
  private
  def find_words(current, y, x, visited)
    found = []

    if !BoggleDictionary.prefix?(current)
      return found
    end

    found << current if BoggleDictionary.word?(current)
    DIRECTIONS.each do |dx, dy|
      nx, ny = x + dx, y + dy
      # if in_board(ny, nx) && !visited[ny][nx]
      if in_board(ny, nx) && !visited.include?([ny,nx])
        visited << [ny,nx]
        new_letter = board[ny][nx]
        new_current = current+new_letter
        found += find_words(new_current, ny, nx, visited)
        visited.delete([ny,nx])
      end
    end
    return found.uniq
  end


  def in_board(y,x)
    y>=0 && y<num_rows && x >=0 && x<num_columns
  end


  def num_rows
    @num_rows ||= board.length
  end

  def num_columns
    @num_rows ||= board[0].length
  end
end