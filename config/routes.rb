Rails.application.routes.draw do

  root 'welcome#index'

  get 'lift_pass/:id' => 'lift_pass#index', as: 'lift_pass'

  get 'day_ride/:id' => 'lift_pass#day_ride', as: 'day_ride'

  get 'save_wtp' => 'lift_pass#save_wtp'

  get 'my_hats' => 'welcome#my_hats', as: 'my_hats'

end
