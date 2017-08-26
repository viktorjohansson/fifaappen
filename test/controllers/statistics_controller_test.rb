require 'test_helper'

class StatisticsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get teams" do
    get :teams
    assert_response :success
  end

  test "should get players" do
    get :players
    assert_response :success
  end

  test "should get show_team" do
    get :show_team
    assert_response :success
  end

  test "should get show_player" do
    get :show_player
    assert_response :success
  end

end
