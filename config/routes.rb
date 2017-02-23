# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
#resources :contacts , :only => [:destroy, :update]
resources :projects do
  resources :contacts
end

