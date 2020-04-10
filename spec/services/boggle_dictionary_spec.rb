RSpec.describe BoggleDictionary do
  let(:cache_value) {}
  before { allow(Rails.cache).to receive(:fetch).and_return(cache_value) }

  describe '#word?' do
    subject { described_class.word?(word) }
    context 'longer than 3 chars' do
      let(:word) { 'long' }
      context 'cache value is 2' do
        let(:cache_value) { 2 }
        it { is_expected.to be(true) }
      end

      context 'cache value is not 2' do
        let(:cache_value) { 1 }
        it { is_expected.to be(false) }
      end
    end

    context 'shorter than 3 chars' do
      let(:word) { 'ab' }
      it { is_expected.to be(false) }
    end
  end

  describe '#prefix?' do
    subject { described_class.prefix?('i')}
    context 'cache value is not present' do
      let(:cache_value) { nil }
      it { is_expected.to be(false) }
    end

    context 'cache value is 1' do
      let(:cache_value) { 1 }
      it { is_expected.to be(true) }
    end

    context 'cache value is greater than 1' do
      let(:cache_value) { 2 }
      it { is_expected.to be(true) }
    end
  end
end

