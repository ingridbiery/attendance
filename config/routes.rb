Rails.application.routes.draw do
  resources :arts do
    resources :belts, except: :index
    resources :courses do
      resources :meetings, only: [:new, :create, :show, :destroy]
    end
  end

  resources :families do
    resources :people, except: :index
  end
  get 'people' => 'people#index', as: :people

  # Defines the root path route ("/")
  root "arts#index"
end
