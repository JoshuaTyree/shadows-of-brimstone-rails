class AbilitiesController < ApplicationController
  before_action :set_player

  def new
    @ability = Ability.new(player_id: params[:player_id])
  end

  def create
    @ability = Ability.new(ability_params)
    if @ability.save
      render "players/show"
    else
      
    end
  end


  private

  def set_player
    @player = Player.find params[:player_id]
  end

  def ability_params
    params.require(:ability).permit(

    )
  end

end
