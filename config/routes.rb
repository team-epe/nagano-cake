
Rails.application.routes.draw do
  root to: 'public/homes#top'

  namespace :admin do
    resources :items, only: [:create, :index, :new, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :update, :edit]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
    #resources :sessions, only: [:new, :create, :destroy]
    get '/' => 'homes#top'
  end
  namespace :public do
    resources :items, only: [:index, :show]
    resources :cart_items, only: [:index, :create, :update, :destroy, :destroy_all]
    resources :customers, only: [:show, :edit, :update, :unsubscribe, :withdrow]
    resources :orders, only: [:new, :create, :check, :complete, :index, :show]
    resources :addresses, only: [:index, :destroy, :edit, :update, :create]
    #resources :sessions, only: [:new, :create, :destroy]
    #resources :registrations, only: [:new, :create]
<<<<<<< HEAD
     get '/about' => 'homes#about'
=======
    get '/about' => 'homes#about'
    get 'customer/withdraw'
>>>>>>> 81affd30eaa5b799c80238b3e53559e30a807207
    root to: 'homes#top'
    get '/customers/my_page' => 'customers#show', as: 'my_page'
  end

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
end
