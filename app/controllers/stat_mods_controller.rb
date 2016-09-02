class StatModsController < ApplicationController

  def create
    @stat_mod = StatMod.new mod_params
    puts mod_params
    @player = Player.find mod_params[:modifiable_id]
    if @stat_mod.save
      redirect_to edit_player_path(@player), notice: "Stat Mod added!"
    else
      redurect_to edit_player_path(@player), error: "Failed to add Stat Mod"
    end
  end

  private

  def mod_params
    params.require(:stat_mod).permit(
      :modifiable_id,
      :modifiable_type,
      :stat_name,
      :amount
    )
  end
end
