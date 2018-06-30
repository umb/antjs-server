require 'rest-client'

class GamesController < ApplicationController
  before_action :set_game, only: [:show, :start, :update, :destroy]

  @@server_url = 'https://antjs-engine-hack.apps-dev.umb.cloud/'
  @@max_duration = 1000

  # GET /games
  def index
    @games = Game.all

    render json: @games
  end

  # GET /games/1
  def show
    game = Game.find(@game.id).as_json(include: :frames)

    transformFramesToHash(game, game['frames'])

    render json: game
  end

  def start
    if not @game.completed
      @game.players.push(Player.find(params[:playerId]))
      @game.save!

      if @game.players.length > 1
        start_game
      end

      game = Game.find(@game.id).as_json(include: [:frames, :players])

      transformFramesToHash(game, game[:frames])

      render json: game
    end
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

  def start_game
    @game.completed
    @game.save!

    response = RestClient::Request.execute(method: :post, url: @@server_url + 'step', timeout: 10, headers: {params: {steps: @@max_duration}})
    frames = JSON.parse(response.body)['frames']

    frames.each do |frame|
      newFrame = Frame.new({value: frame})
      newFrame.game_id = @game.id
      newFrame.save!
    end
    frames
  end

  def transformFramesToHash(game, frames)
    if frames && frames.length > 0
      game['frames'] = frames.map do |frame|
        frame = frame.merge(JSON.parse(frame['value']))
        frame.delete('value')
        frame
      end
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_game
    @game = Game.includes(:frames).find(params[:id] || params[:game_id])
  end

  # Only allow a trusted parameter "white list" through.
  def game_params
    params.require(:game).permit(:external_id)
  end

end
