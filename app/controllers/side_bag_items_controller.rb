class SideBagItemsController < ApplicationController

  def create
    @item = SideBagItem.new item_params
    @player = Player.find item_params[:player_id]
    if @player.stat_with_bonus(:side_bag_slots) <= @player.side_bag_items.count
      flash[:error] = "Side Bag is full"
      redirect_to edit_player_path(@player, anchor: 'side-bag-form')
    else
      if @item.save
        redirect_to edit_player_path(@player, anchor: 'side-bag-form'), notice: 'Item added successfully'
      else
        flash[:error] ='Failed to add item'
        redirect_to edit_player_path(@player, anchor: 'side-bag-form')
      end
    end
  end

  def destroy
    @item = SideBagItem.find params[:id]
    @item.destroy
  end

  private

  def item_params
    params.require(:side_bag_item).permit(
      :player_id,
      :name
    )
  end

end
