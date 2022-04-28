Rails.application.routes.draw do

  devise_for :customers

  devise_for :admin, controllers: {
    sessions:      'admin/sessions',
    passwords:     'admin/passwords',
    registrations: 'admin/registrations'
  }

  namespace :admin do
    get '/' => 'homes#top'
    resources :items, only:[:index, :new, :show, :edit, :create, :update]
    resources :customers, only:[:index, :edit, :show, :update]
    resources :orders, only:[:show, :update]
  end

  scope module: :public do
    get '/' => 'homes#top'
    get 'about' => 'homes#about'
    resources :items, only:[:index, :show]
    get 'customers/my_page' => 'customers#show'
    get 'customers/unsbscride' => 'customers#create'
    patch 'customers/withdraw' => 'customers#destroy'
    resources :customers, only:[:edit, :update]
    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only:[:index, :update, :destroy, :create]
    post 'orders/comfirm' => 'orders#comfirm'
    get 'orders/complete' => 'orders#complete'
    resources :orders, only:[:new, :index, :show, :create]
    resources :addresses, only:[:index, :edit, :create, :update, :destroy]


  end
end
