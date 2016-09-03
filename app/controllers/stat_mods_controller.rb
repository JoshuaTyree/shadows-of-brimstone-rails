class StatModsController < ApplicationController

  def create
    @stat_mod = StatMod.new mod_params
    @player = Player.find mod_params[:modifiable_id]

    if mod_params[:amount].to_i == 0
      flash[:error] = "0 is an invalid stat mod"
      redirect_to(edit_player_path(@player, anchor: 'stat-mod-form')) and return
    end

    if @stat_mod.save
      redirect_to edit_player_path(@player, anchor: 'stat-mod-form'), notice: "Stat Mod added!"
    else
      flash[:error] = "Failed to add Stat Mod"
      redirect_to edit_player_path(@player, anchor: 'stat-mod-form')
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
