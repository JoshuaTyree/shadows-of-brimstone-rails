class AbilitiesController < ApplicationController

  def create
    @ability = Ability.new ability_params
    @player = ability_params[:player_id]
    if @ability.save
      redirect_to edit_player_path(@player, anchor: 'ability-form'), notice: "Successfully added ability"
    else
      flash[:error] = "Failed to create ability"
      redirect_to edit_player_path(@player, anchor: 'ability-form')
    end
  end

  private

  def ability_params
    params.require(:ability).permit(
      :player_id,
      :name,
      :description,
      :stat_mods_attributes => [
        :id,
        :stat_name,
        :amount,
        :_destroy
      ]
    )
  end
end
