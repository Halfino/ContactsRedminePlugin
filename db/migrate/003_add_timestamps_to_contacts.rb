class AddTimestampsToContacts < ActiveRecord::Migration
  def change
    add_timestamps(:contacts)
  end
end
