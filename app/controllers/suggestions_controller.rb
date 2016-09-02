class SuggestionsController < ApplicationController
  respond_to :json


  def abilities
  end

  def items
    @items = Ability.all.uniq_by{|x| x.name}
    render json: @items.map{|y| { id: y.id, value: y.name }}
  end


end
