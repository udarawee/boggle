require 'test_helper'

class GamesControllerTest < ActionDispatch::IntegrationTest
  test "should succeed" do
    post games_path
    assert_response :success
  end

  test "should return a 4x4 board" do
    post games_path
    board = response.parsed_body["board"]
    assert_equal(4, board.length)
    assert_equal(4, board.first.length)
  end
end
