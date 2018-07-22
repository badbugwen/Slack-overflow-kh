Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:show, :edit, :update] do
    member do
      # favorite_user GET /users/:id/favorite(.:format) users#favorite
      get :favorite
    end
  end
  resources :questions, only: [:index, :show, :new, :create] do
    resources :solutions, only: [:create]
    member do
      post :favorite
      post :unfavorite

      post :upvote
      post :unupvote
    end
  end

  root "questions#index"
end
