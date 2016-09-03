Rails.application.routes.draw do
  root to: "players#index"
  resources :stat_mods
  resources :abilities
  resources :items
  resources :side_bag_items

  resources :players do
    get :levelup, to: "players#levelup"

    collection do
      post :add_stat, to: 'players#add_stat'
      post :add_ability, to: 'players#add_ability'
      post :add_item, to: 'players#add_item'
    end
  end
end
