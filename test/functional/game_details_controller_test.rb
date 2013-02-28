require 'test_helper'

class GameDetailsControllerTest < ActionController::TestCase
  setup do
    @game_detail = game_details(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:game_details)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create game_detail" do
    assert_difference('GameDetail.count') do
      post :create, game_detail: {  }
    end

    assert_redirected_to game_detail_path(assigns(:game_detail))
  end

  test "should show game_detail" do
    get :show, id: @game_detail
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @game_detail
    assert_response :success
  end

  test "should update game_detail" do
    put :update, id: @game_detail, game_detail: {  }
    assert_redirected_to game_detail_path(assigns(:game_detail))
  end

  test "should destroy game_detail" do
    assert_difference('GameDetail.count', -1) do
      delete :destroy, id: @game_detail
    end

    assert_redirected_to game_details_path
  end
end
