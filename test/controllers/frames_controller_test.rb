require 'test_helper'

class FramesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @frame = frames(:one)
  end

  test "should get index" do
    get frames_url, as: :json
    assert_response :success
  end

  test "should create frame" do
    assert_difference('Frame.count') do
      post frames_url, params: { frame: { game_id: @frame.game_id } }, as: :json
    end

    assert_response 201
  end

  test "should show frame" do
    get frame_url(@frame), as: :json
    assert_response :success
  end

  test "should update frame" do
    patch frame_url(@frame), params: { frame: { game_id: @frame.game_id } }, as: :json
    assert_response 200
  end

  test "should destroy frame" do
    assert_difference('Frame.count', -1) do
      delete frame_url(@frame), as: :json
    end

    assert_response 204
  end
end
