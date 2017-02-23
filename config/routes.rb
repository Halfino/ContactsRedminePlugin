# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
resources :contacts , :only => [:destroy]


get 'projects/:id/contacts', :to => 'contacts#index', as: 'contacts'
get 'projects/:id/contacts/new', :to => 'contacts#new', as: 'new_contact'
get 'projects/:id/contacts/:id', :to => 'contacts#show', as: 'show_contact'
get 'projects/:id/contacts/:id/edit', :to => 'contacts#edit', as: 'edit_contact'
post 'projects/:id/contacts', :to => 'contacts#create'
patch 'projects/:id/contacts/:id', :to => 'contacts#update'


#get 'contacts', :to => 'contacts#index'
#post 'contacts', :to => 'contacts#create'
#get 'new_contact', :to => 'contacts#new'

