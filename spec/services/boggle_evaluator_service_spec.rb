require_relative '../../app/services/boggle_evaluator_service'
require 'minitest/spec'
require 'minitest/autorun'

describe 'BoggleEvaluatorService' do
  let(:board) do
    [
      %w(H E T L),
      %w(O I O X),
      %w(W R P T),
      %w(E B I Q),
    ]
  end

  subject { ::BoggleEvaluatorService.new(board, answers) }
  let(:invalid_words) { %w(ETLF SOX E) }
  let(:valid_words) { %w(HETL OX PT LTEH RW) }
  let(:answers) { valid_words + invalid_words }

  describe '#valid_words' do
    describe 'words exist' do
      it 'returns the valid words' do
        result = subject.valid_words
        _(result).must_equal(valid_words)
      end
    end
  end

  describe '#score' do
    it 'sums up the lengths of the letters' do
      _(subject.score).must_equal(14)
    end
  end
end
