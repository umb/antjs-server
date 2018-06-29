class CodeUploadsController < ApplicationController
  before_action :set_code_upload, only: [:show, :update, :destroy]

  # GET /code_uploads
  def index
    @code_uploads = CodeUpload.all

    render json: @code_uploads
  end

  # GET /code_uploads/1
  def show
    render json: @code_upload
  end

  # POST /code_uploads
  def create
    @code_upload = CodeUpload.new(code_upload_params)

    if @code_upload.save
      render json: @code_upload, status: :created, location: @code_upload
    else
      render json: @code_upload.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /code_uploads/1
  def update
    if @code_upload.update(code_upload_params)
      render json: @code_upload
    else
      render json: @code_upload.errors, status: :unprocessable_entity
    end
  end

  # DELETE /code_uploads/1
  def destroy
    @code_upload.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_code_upload
      @code_upload = CodeUpload.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def code_upload_params
      params.permit(:player_id, :code)
    end
end
