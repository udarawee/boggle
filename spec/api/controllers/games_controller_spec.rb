RSpec.describe Api::GamesController, type: :controller do
  describe '#create' do
    before do
      allow_any_instance_of(BoggleService).to receive(:board).and_return(mock_board)
      allow_any_instance_of(BoggleSolver).to receive(:find_all_words).and_return(mock_valid_words)
    end
    let(:mock_board) { [%w(A B), %w(C D)] }
    let(:mock_valid_words) { %w(HI THERE) }
    let(:word_hashes) { mock_valid_words.map { |w| Digest::MD5.hexdigest(w) } }

    it 'returns a board with valid words' do
      post :create
      resp_body = JSON.parse(response.body).to_h
      expect(resp_body["board"]).to eq(mock_board)
      expect(resp_body["valid_words"]).to eq(word_hashes)
    end
  end
end