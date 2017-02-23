class AddProjectIdToContacts < ActiveRecord::Migration
  def up
    add_column :contacts, :project_id, :integer
  end
end
