require_relative '../../app/services/boggle_solver'
# require_relative '../../app/services/boggle_dictionary'
require 'minitest/spec'
require 'minitest/autorun'

describe 'BoggleSolverService' do
  let(:board) do
    [
      %w(T O),
      %w(O P),
    ]
  end

  subject { ::BoggleSolver.new(board) }

  describe '#valid_words' do
    describe 'words exist' do
      it 'returns the valid words' do
        Rails.stub(:cache, 2) do
          result = subject.find_all_words
          _(result).must_equal([])
        end
      end
    end
  end
end

