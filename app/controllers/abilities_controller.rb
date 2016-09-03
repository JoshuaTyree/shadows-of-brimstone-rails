class AbilitiesController < ApplicationController

  def create
    @ability = Ability.new ability_params
    if @ability.save
      redirect_to player_path(@ability.player, anchor: 'ability-form'), notice: "Successfully added ability"
    else
      flash[:error] = "Failed to create ability"
      redirect_to edit_player_path(@ability.player, anchor: 'ability-form')
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
