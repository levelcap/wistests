Rails.application.routes.draw do
  get 'people/index'
  post 'people/upload'
  root 'people#index'
end
