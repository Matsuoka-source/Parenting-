Rails.application.routes.draw do
  get 'contacts/new'
  get 'contacts/create'
  get 'homes/about'
  root to: 'homes#top'
  devise_for :users
  resources :posts do
    # いいねとコメントはpostモデルにネスト
    resource :favorites,only: [:create, :destroy]

    resources :post_comments, only: [:create, :destroy]
  end
  resources :users, only: [:show, :edit, :update, :index] do
    # relationshipsは中間テーブルなので,userモデルにネスト
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  resource :contacts, only: [:new, :create] do
    get "/thanks" => "contacts#thanks"
  end
  
  get '/search', to: 'searchs#search'

end
