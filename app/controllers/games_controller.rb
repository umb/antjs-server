require 'rest-client'

class GamesController < ApplicationController
  before_action :set_game, only: [:show, :update, :destroy]

  @@server_url = 'https://antjs-engine-hack.apps-dev.umb.cloud/'
  @@max_duration = 1000

  # GET /games
  def index
    @games = Game.all

    render json: @games
  end

  # GET /games/1
  def show
    if not @game.completed
      response = RestClient::Request.execute(method: :post, url: @@server_url + 'step',
                                             timeout: 10, headers: {params: {steps: @@max_duration}})

      frames = JSON.parse(response.body)['frames']
      if frames && frames.length >= @@max_duration
        @game.completed
        @game.save!
        if @game.frames&.length == 0
          frames.each do |frame|
            newFrame = Frame.new({value: frame})
            newFrame.game_id = @game.id
            newFrame.save!
          end
        end
      end
    end

    game = Game.find(@game.id).as_json(include: :frames)

    game['frames'] = game['frames'].map do |frame|
      frame = frame.merge(JSON.parse(frame['value']))
      frame.delete('value')
      frame
    end

    render json: game
  end

  # POST /games
  def create
    game_size = 30

    response = RestClient.get(@@server_url)


    if response.body&.length > 0
      game = Game.where(external_id: JSON.parse(response.body)['id']).first
    end

    if game
      render json: game
    else
      response = RestClient::Request.execute(method: :post, url: @@server_url + 'game',
                                             timeout: 10, headers: {params: {size: game_size, maxDuration: @@max_duration}})

      @game = Game.new({external_id: JSON.parse(response.body)['id']})

      if @game.save
        render json: @game, status: :created, location: @game
      else
        render json: @game.errors, status: :unprocessable_entity
      end
    end


  end

  # PATCH/PUT /games/1
  def update
    if @game.update(game_params)
      render json: @game
    else
      render json: @game.errors, status: :unprocessable_entity
    end
  end

  # DELETE /games/1
  def destroy
    @game.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.includes(:frames).find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def game_params
    params.require(:game).permit(:external_id)
  end

end
