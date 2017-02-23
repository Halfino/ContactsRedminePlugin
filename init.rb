Redmine::Plugin.register :contacts do
  name 'Contacts plugin'
  author 'Jan Koranda'
  description 'This is a test task plugin for Redmine'
  version '0.0.1'

  project_module :contacts do
    permission :view_contacts, :contacts => [:index, :show]
    permission :create_contact, :contacts => [:index, :show, :new, :create]
    permission :edit_contact, :contacts => [:index, :show, :edit, :new, :create, :update]
    permission :delete_contacts, :contacts => [:index, :show, :destroy]
  end

  menu :project_menu, :contacts, :project_contacts_path, :caption => 'Contacts',
    :after => :news

end

Redmine::Search.available_search_types << 'contacts'
Redmine::Activity.register :contacts
CustomFieldsHelper::CUSTOM_FIELDS_TABS << {:name => 'ContactCustomField', :partial => 'custom_fields/index',
                                            :label => :label_contact_plural}