require 'test_helper'

class CodeUploadsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @code_upload = code_uploads(:one)
  end

  test "should get index" do
    get code_uploads_url, as: :json
    assert_response :success
  end

  test "should create code_upload" do
    assert_difference('CodeUpload.count') do
      post code_uploads_url, params: { code_upload: { code: @code_upload.code, player_id: @code_upload.player_id } }, as: :json
    end

    assert_response 201
  end

  test "should show code_upload" do
    get code_upload_url(@code_upload), as: :json
    assert_response :success
  end

  test "should update code_upload" do
    patch code_upload_url(@code_upload), params: { code_upload: { code: @code_upload.code, player_id: @code_upload.player_id } }, as: :json
    assert_response 200
  end

  test "should destroy code_upload" do
    assert_difference('CodeUpload.count', -1) do
      delete code_upload_url(@code_upload), as: :json
    end

    assert_response 204
  end
end
