Rails.application.routes.draw do

  root 'welcome#index'

  get 'lift_pass/:id' => 'lift_pass#index', as: 'lift_pass'

  get 'save_wtp' => 'lift_pass#save_wtp'

end
