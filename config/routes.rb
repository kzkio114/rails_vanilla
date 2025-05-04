Rails.application.routes.draw do

  get "/up", to: proc { [200, { "Content-Type" => "text/plain" }, ["OK"]] }
  get "/privacy", to: "static_pages#privacy", as: :privacy

  resources :ogp_templates, only: [:show]

  resources :omikujis, only: %i[index create] do
    collection do
      post :reset
    end
  end

  resource :modal, only: [:show, :create, :destroy]

  namespace :internal do
    post "ogp_upload", to: "ogp_images#create"
  end

  root "tops#index"

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
