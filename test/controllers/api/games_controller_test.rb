require 'test_helper'

class Api::GamesControllerTest < ActionDispatch::IntegrationTest
  test "should succeed" do
    post api_games_path
    assert_response :success
  end

  test "should return a 4x4 board" do
    post api_games_path
    board = response.parsed_body["board"]
    assert_equal(4, board.length)
    assert_equal(4, board.first.length)
  end
end
