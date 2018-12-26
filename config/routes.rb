Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount Posko::Browser::Engine => "/posko-browser"
  root 'sessions#new'
  delete 'sign_out' => 'sessions#destroy'
  get 'sign_out' => 'sessions#destroy'
  get 'sign_in' => 'sessions#new'
  post 'sign_in' => 'sessions#create'
  get 'sign_up' => 'accounts#new'
  post 'sign_up' => 'accounts#create'
  get 'dashboard' => 'pages#dashboard'
  resources :accounts, only: [:create]
  resources :categories, shallow: true do
    resources :subcategories
  end
  resources :users, shallow: true do
    resources :shifts, shallow: true do
      resources :shift_activities
      member do
        get :end_shift
        patch :finalize_shift
      end
    end
  end
  resources :products, shallow: true do
    collection do
      get :import_modal
      post :import
    end
    resources :variants, shallow: true do
      resources :components
    end
    resources :option_types, shallow: true do
      resources :option_values
    end
  end
  resources :barcodes do
    collection do
      get :search
      get :print
    end
  end
  resources :barcodes do
    get :search
    get :print
  end
  resources :barcodes do
    get :search
    get :print
  end
  resources :customers
  resources :invoices
  resources :roles

  constraints format: 'json' do
    namespace :api, defaults: { format: :json } do
      namespace :v1 do
        post 'sign_in' => 'auth#sign_in'
        resources :users do
          collection do
            get :count
          end
        end

        resources :access_keys do
          collection do
            get :count
          end
        end

        resources :customers do
          collection do
            get :count
          end
        end

        resources :variants, only: [:index, :count] do
          collection do
            get :count
          end
        end

        resources :categories do
          collection do
            get :count
          end
        end

        resources :products, shallow: true do
          collection do
            get :count
          end
          resources :variants, shallow: true do
            collection do
              get :count
            end
            resources :components do
              collection do
                get :count
              end
            end
          end
          resources :option_types, shallow: true do
            collection do
              get :count
            end
            resources :option_values do
              collection do
                get :count
              end
            end
          end
        end
        resources :invoices, shallow: true do
          collection do
            get :count
          end
          resources :invoice_lines do
            collection do
              get :count
            end
          end
        end
        resources :shifts do
          collection do
            get :current
            patch :end_shift
          end
        end
      end
    end
  end
end
