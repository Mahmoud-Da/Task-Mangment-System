Rails.application.routes.draw do
  root 'tasks#index'
  resources :tasks
  resources :categories do
    collection do
      get 'search'
    end
  end
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  # namespaceを利用することで、 /api/v1/each_api 形式のrouting設定を行う
  namespace :api, format: 'json' do
    namespace :v1 do
      resources :tasks
      resources :categories
    end
  end
end
