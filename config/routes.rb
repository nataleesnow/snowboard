Rails.application.routes.draw do

  root 'welcome#index'

  get 'lift_pass/:id' => 'lift_pass#index', as: 'lift_pass'

  get 'get_day_ride/:id' => 'lift_pass#get_day_ride', as: 'get_day_ride'

  get 'save_wtp' => 'lift_pass#save_wtp'

end
