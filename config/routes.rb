Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  resources :users, only: [:create, :index, :update, :show, :destroy]
  post "/login", to: "users#login"  

  resources :testimonials, only: [:index, :create, :update, :destroy, :show] 

  resources :student_placements, only: [:index, :create, :show]
  
  resources :companies, only: [:index, :create, :show, :update]

  resources :company_placements, only: [:index, :create]

  resources :opportunities, only: [:create, :index, :update, :destroy]
  put "/close_opportunity/:id", to: "opportunities#close_opportunity"

  resources :user_applications, only: [:create, :index, :update, :destroy]

  resources :users, only: [:index] do 
    resources :companies, only: [:index] do
      resources :opportunities, only: [:index] do 
        resources :user_applications, only: [:create, :index, :update, :destroy]
      end
    end
  end

  resources :companies, only: [:index] do
    resources :opportunities, only: [:create, :index]
  end

  resources :companies, only: [:index] do
    resources :company_placements, only: [:index, :create]
  end
  
  resources :companies, only: [:index] do
    resources :student_placements, only: [:index, :create]
  end

end
