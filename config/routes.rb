Rails.application.routes.draw do

  resources :events do
    match '/scrape', to: 'events#scrape', via: :post, on: :collection
  end
  root to: 'events#index'
  post 'scrape_event', to: 'events#scrape_event'
end
