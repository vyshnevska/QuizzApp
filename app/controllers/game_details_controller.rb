class GameDetailsController < ApplicationController
  # GET /game_details
  # GET /game_details.json
  def index
    @game_details = GameDetail.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @game_details }
    end
  end

  # GET /game_details/1
  # GET /game_details/1.json
  def show
    @game_detail = GameDetail.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game_detail }
    end
  end

  # GET /game_details/new
  # GET /game_details/new.json
  def new
    @game_detail = GameDetail.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game_detail }
    end
  end

  # GET /game_details/1/edit
  def edit
    @game_detail = GameDetail.find(params[:id])
  end

  # POST /game_details
  # POST /game_details.json
  def create
    @game_detail = GameDetail.new(params[:game_detail])

    respond_to do |format|
      if @game_detail.save
        format.html { redirect_to @game_detail, notice: 'Game detail was successfully created.' }
        format.json { render json: @game_detail, status: :created, location: @game_detail }
      else
        format.html { render action: "new" }
        format.json { render json: @game_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /game_details/1
  # PUT /game_details/1.json
  def update
    @game_detail = GameDetail.find(params[:id])

    respond_to do |format|
      if @game_detail.update_attributes(params[:game_detail])
        format.html { redirect_to @game_detail, notice: 'Game detail was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game_detail.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_details/1
  # DELETE /game_details/1.json
  def destroy
    @game_detail = GameDetail.find(params[:id])
    @game_detail.destroy

    respond_to do |format|
      format.html { redirect_to game_details_url }
      format.json { head :no_content }
    end
  end
end
