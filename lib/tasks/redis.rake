namespace :redis do
  require_relative '../../app/services/dictionary_loader_service'

  desc "seeds cache with words from dictionary"
  task :setup, [:mode] => :environment do |_, args|
    file_name = args[:mode] == 'simple' ? 'dictionary_raw_simple.txt' : 'dictionary_raw.txt'
    pp file_name
    DictionaryLoaderService.new(file_name).call
  end
end
