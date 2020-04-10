RSpec.describe BoggleSolver do
  let(:board) do
    [
      %w(T O),
      %w(O P),
    ]
  end

  subject { BoggleSolver.new(board) }

  describe '#find_all_words' do

    before do
      allow(BoggleDictionary).to receive(:prefix?).and_return(true)
      allow(BoggleDictionary).to receive(:word?).and_return(false)
      allow(BoggleDictionary).to receive(:word?).with('TOP').and_return(true)
      allow(BoggleDictionary).to receive(:word?).with('TOO').and_return(true)
      allow(BoggleDictionary).to receive(:word?).with('POT').and_return(true)
    end


    context 'words exist' do
      it 'finds the valid words' do
        result = subject.find_all_words
        expect(result.sort).to include('POT', 'TOP', 'TOO')
      end
    end
  end
end

