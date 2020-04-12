RSpec.describe DictionaryLoaderService do
  describe '#call' do
    subject { described_class.new('random_path') }

    let(:mock_file_contents) do
      %W(ab\r\n abs\r\n absolutely\r\n)
    end
    let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) }
    let(:cache) { Rails.cache }

    before do
      allow(Rails).to receive(:cache).and_return(memory_store)
      allow(File).to receive(:open).and_return(mock_file_contents)
      Rails.cache.clear
      subject.call
    end

    context 'when it is a complete word' do
      it 'writes to cache with the word value' do
        expect(cache.read('absolutely')).to eq(2)
        expect(cache.read('ab')).to eq(2)
        expect(cache.read('abs')).to eq(2)
      end

      context 'when it is not a complete word' do
        it 'writes to cache with the prefix value' do
          expect(cache.read('a')).to eq(1)
          expect(cache.read('abso')).to eq(1)
          expect(cache.read('absol')).to eq(1)
          expect(cache.read('absolu')).to eq(1)
          expect(cache.read('absolut')).to eq(1)
          expect(cache.read('absolute')).to eq(1)
          expect(cache.read('absolutel')).to eq(1)
        end
      end
    end
  end
end

