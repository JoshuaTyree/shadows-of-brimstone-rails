class PlayersController < ApplicationController
  respond_to :js, :html
  before_action :set_player, only: [
    :edit, :update, :destroy, :show
  ]

  def index
    @players = Player.all
  end

  def show
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new player_params
    if @player.save
      redirect_to @player, notice: 'Player created!'
    else
      render :new, error: 'Failed to create player'
    end
  end

  def edit
    @ability = @player.abilities.new
    @ability.stat_mods.build
    @item = @player.items.new
    @item.stat_mods.build
    @stat_mod = StatMod.new(modifiable: @player, amount: 0)
    @stats = [
      ["Combat", "combat"],
      ["Max Grit", "max_grit"],
      ["Range To-Hit", "range_to_hit"],
      ["Melee To-Hit", "melee_to_hit"],
      ["Agility", "agility"],
      ["Cunning", "cunning"],
      ["Spirit", "spirit"],
      ["Strength", "strength"],
      ["Lore", "lore"],
      ["Luck", "luck"],
      ["Initiative", "initiative"],
      ["Health", "health"],
      ["Sanity", "sanity"],
      ["Defense", "defense"],
      ["Willpower", "willpower"]
    ]
  end

  def update
    if @player.update player_params
      flash[:notice] = "Updated player successfully!"
      redirect_to @player
    else
      flash[:alert] = "Failed to update player."
      render :edit
    end
  end

  def destroy
    @player.destroy
    redirect_to players_path
  end


  def add_experience
    @player = Player.find params[:player_id]
    unless params[:amount].blank? or @player.xp >= 8000
      amount = params[:amount].to_i
      amount = amount + @player.xp
      @player.update!(xp: amount)
    end

    render "show"
  end

  def add_money
    @player = Player.find params[:player_id]
    unless params[:amount].blank?
      amount = params[:amount].to_i
      amount = amount + @player.money
      @player.update!(money: amount)
    end
    render "show"
  end

  def add_wound
    @player = Player.find params[:player_id]
    unless @player.wounds >= @player.character.health
      amount = @player.wounds + 1
      @player.update!(wounds: amount)
    end
    render "show"
  end

  def heal
    @player = Player.find params[:player_id]
    unless @player.wounds < 1
      amount = @player.wounds - 1
      @player.update!(wounds: amount)
    end
    render "show"
  end

  def add_horror
    @player = Player.find params[:player_id]
    unless @player.horror_wounds >= @player.character.sanity
      amount = @player.horror_wounds + 1
      @player.update!(horror_wounds: amount)
    end
    render "show"
  end

  def heal_horror
    @player = Player.find params[:player_id]
    unless @player.horror_wounds < 1
      amount = @player.horror_wounds - 1
      @player.update!(horror_wounds: amount)
    end
    render "show"
  end

  def levelup
    @player = Player.find params[:player_id]
    unless !@player.can_level_up?
      @player.levelup!
    end
    render "show"
  end

  def add_darkstone
    @player = Player.find params[:player_id]
    unless params[:amount].blank?
      amount = @player.darkstone + params[:amount].to_i
      @player.update!(darkstone: amount)
    end
    render "show"
  end

  private

  def set_player
    @characters = Character.all
    @player = Player.find params[:id]
  end

  def player_params
    params.require(:player).permit(
      :character_id,
      :name,
      :wounds,
      :horror_wounds,
      :corruption,
      :xp,
      :money,
      :darkstone
    )
  end

end
