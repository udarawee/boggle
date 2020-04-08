namespace :redis do
  desc "seeds cache with words from dictionary"
  task setup: :environment do
    path = File.join(Rails.root, 'app', 'assets', 'dictionary_raw.txt')
    File.open(path, 'rb').each do |line|
      pp line.strip
      Rails.cache.write(line.strip, 1)
    end
  end
end
