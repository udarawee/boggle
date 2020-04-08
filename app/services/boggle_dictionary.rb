class BoggleDictionary
  def self.exists?(word)
    Rails.cache.fetch(word.downcase).present?
  end
end
