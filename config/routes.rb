Rails.application.routes.draw do
  resources :arts do
    resources :belts, except: :index
  end

  resources :families do
    resources :people, except: :index
  end
  get 'people' => 'people#index', as: :people

  # Defines the root path route ("/")
  root "home#index"
end
