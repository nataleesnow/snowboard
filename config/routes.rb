Rails.application.routes.draw do
  root 'welcome#index'

  get 'ride/:id' => 'ride#index', as: :rider_data

  get 'save_wtp' => 'welcome#save_wtp'

end
