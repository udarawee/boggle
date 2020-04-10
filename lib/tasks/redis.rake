namespace :redis do
  desc "seeds cache with words from dictionary"
  task setup: :environment do
    path = File.join(Rails.root, 'app', 'assets', 'dictionary_raw.txt')
    WORD_VALUE = 2
    PREFIX_VALUE = 1

    File.open(path, 'rb').each do |line|
      word = line.strip

      (0..word.length-1).each do |i|
        slice = word[0..i]
        # at final letter
        if slice.length == word.length
          Rails.cache.write(slice, WORD_VALUE)
          next
        end
        # do nothing if this prefix already exists
        existing_entry = Rails.cache.fetch(slice)
        next if existing_entry.present?
        Rails.cache.write(slice, PREFIX_VALUE)
      end
    end

  end
end


board = BoggleService.new.board

s = BoggleSolver.new(board)
s.find_all_words