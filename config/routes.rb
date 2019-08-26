Rails.application.routes.draw do
  #get 'home/Index'
  get 'display' => 'home#Index'
  get 'create' => 'home#filldb'
  get 'delete' => 'home#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
