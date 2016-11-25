Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root                    to: 'static_pages#home'

  get '/contact',         to: 'static_pages#contact'

  get "*any", via: :all,  to: "errors#not_found"
end
