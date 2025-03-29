# config/routes.rb

Rails.application.routes.draw do
  get "/up", to: proc { [200, { "Content-Type" => "text/plain" }, ["OK"]] }

  root "tops#index"

  resource :modal, only: [:show, :create, :destroy]

  resources :omikujis, only: %i[index create] do
    collection do
      post :reset
    end
  end
end
