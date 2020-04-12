RSpec.describe BoggleSolver do
  let(:board) do
    [
      %w(T A T),
      %w(O P O),
      %w(D S E),
    ]
  end

  subject { BoggleSolver.new(board) }

  describe '#find_all_words' do

    before do
      allow(BoggleDictionary).to receive(:prefix?).and_return(true)
      allow(BoggleDictionary).to receive(:word?).and_return(false)
      allow(BoggleDictionary).to receive(:word?).with('TOPS').and_return(true)
      allow(BoggleDictionary).to receive(:word?).with('SPOT').and_return(true)
      allow(BoggleDictionary).to receive(:word?).with('POTATOES').and_return(true)
    end


    context 'words exist' do
      it 'finds the valid words' do
        result = subject.find_all_words
        expect(result.sort).to eq(%w(POTATOES SPOT TOPS))
      end
    end

    context 'when a prefix does not exist' do
      before { allow(BoggleDictionary).to receive(:prefix?).with('TAT').and_return(false)}
      it 'does not keep searching' do
        expect(BoggleDictionary).to_not have_received(:word?).with('TATO')
        expect(BoggleDictionary).to_not have_received(:word?).with('TATP')
      end
      
    end
  end
end

