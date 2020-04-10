class BoggleDictionary
  PREFIX_VALUE = 1
  WORD_VALUE = 2
  def self.word?(word)
    word.length > 2 && entry(word) == WORD_VALUE
  end

  def self.prefix?(word)
    entry(word) >= PREFIX_VALUE
  end

  def self.entry(word)
    Rails.cache.fetch(word.downcase) || 0
  end
end
