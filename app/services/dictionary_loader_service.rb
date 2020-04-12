class DictionaryLoaderService
  attr_reader :path
  def initialize(file_name)
    @path = File.join(Rails.root, 'app', 'assets', file_name)
  end

  def call
    File.open(path, 'rb').each do |line|
      word = line.strip.downcase

      Rails.logger.info "processing word #{word}"
      (0..word.length-1).each do |i|
        slice = word[0..i]
        # at final letter
        if slice.length == word.length
          Rails.cache.write(slice, BoggleDictionary::WORD_VALUE)
          next
        end
        # do nothing if this prefix already exists
        existing_entry = Rails.cache.fetch(slice)
        next if existing_entry.present?
        Rails.cache.write(slice, BoggleDictionary::PREFIX_VALUE)
      end
    end
  end
end