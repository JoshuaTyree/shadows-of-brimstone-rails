class ItemsController < ApplicationController

  def create
    @item = Item.new item_params
    if @item.save
      redirect_to @item.player, notice: "Successfully added item"
    else
      redirect_to edit_player_path(@item.player), error: "Failed to create item"
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :player_id,
      :name,
      :description,
      :equipped,
      :stat_mods_attributes => [
        :id,
        :stat_name,
        :amount,
        :_destroy
      ]
    )
  end
end
