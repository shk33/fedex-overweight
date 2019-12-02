Rails.application.routes.draw do
  get  'home/index'
  post 'home/generate_report'
  get  '/home/:id', to: 'home#show_report', as: 'report'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
end
