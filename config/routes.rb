
Rails.application.routes.draw do

   # 顧客用
# URL /customers/sign_in ...
devise_for :customers,skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

# 管理者用
# URL /admin/sign_in ...
devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html



  root to: 'public/homes#top'

  namespace :admin do
     get '/' => 'homes#top'
    resources :items, only: [:create, :index, :new, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :update, :edit]
    resources :orders, only: [:show, :update, :index]
    resources :order_details, only: [:update]
    #resources :sessions, only: [:new, :create, :destroy]

  end
  namespace :public do
    root to: 'homes#top'
     get '/about' => 'homes#about'
    get 'customer/withdraw' => 'customers#withdraw'
    get '/customers/my_page' => 'customers#show', as: 'my_page'
    get '/cart_items' => 'cart_items#index'
    post 'orders/check'
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete 'destroy_all'
      end
    end
    resources :customers, only: [:show, :edit, :update, :unsubscribe, :withdrow]
    get "orders/complete"
    resources :orders, only: [:new, :create, :index, :show]
    resources :addresses, only: [:index, :destroy, :edit, :update, :create]
    #resources :sessions, only: [:new, :create, :destroy]
    #resources :registrations, only: [:new, :create]

  end

  devise_scope :customer do
    get '/customers/sign_out' => 'devise/sessions#destroy'
  end


end
