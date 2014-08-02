Rails.application.routes.draw do
  root to: "home#index"

  get '/private' => 'home#private', as: :private

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  delete "/session" => "users/session#destroy", as: :destroy_user_session
end
