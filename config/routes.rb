Rails.application.routes.draw do
  root to: "players#index"
  resources :stat_mods
  resources :abilities
  resources :items

  resources :players do
    get :add_experience, to: "players#add_experience"
    get :add_money, to: "players#add_money"
    get :add_wound, to: "players#add_wound"
    get :add_horror, to: "players#add_horror"
    get :heal, to: "players#heal"
    get :heal_horror, to: "players#heal_horror"
    get :add_darkstone, to: "players#add_darkstone"
    get :levelup, to: "players#levelup"

    collection do
      post :add_stat, to: 'players#add_stat'
      post :add_ability, to: 'players#add_ability'
      post :add_item, to: 'players#add_item'
    end
  end
end
