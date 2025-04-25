Rails.application.routes.draw do
  get "/up", to: proc { [200, { "Content-Type" => "text/plain" }, ["OK"]] }

  root "tops#index"

  resource :modal, only: [:show, :create, :destroy]

  resources :omikujis, only: %i[index create] do
    collection do
      post :reset
    end
  end
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
