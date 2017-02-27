class ContactQuery < Query
  self.queried_class = Contact

  self.available_columns = [
      QueryColumn.new(:name, :sortable => "#{Contact.table_name}.name", :groupable => true, :default_order => 'desc'),
      QueryColumn.new(:created_at, :sortable => "#{Contact.table_name}.created_at", :default_order => 'desc'),
      QueryColumn.new(:updated_at, :sortable => "#{Contact.table_name}.updated_at", :default_order => 'desc')
  ]

  def initialize(attributes=nil, *args)
    super attributes
    self.filters ||= {}
  end

  def initialize_available_filters
    add_available_filter "name", :type => :text
    add_available_filter "project_id", :type => :integer
    add_available_filter "created_at", :type => :float
    add_available_filter "updated_at", :type => :float
    add_custom_fields_filters(ContactCustomField)
  end

  def available_columns
    return @available_columns if @available_columns
    @available_columns = self.class.available_columns.dup
    @available_columns += ContactCustomField.visible.
        map {|cf| QueryCustomFieldColumn.new(cf) }
    @available_columns
  end

  def default_columns_names
    @default_columns_names ||= [:project, :name, :created_at, :updated_at]
  end

  def results_scope(options={})
    order_option = [group_by_sort_order, options[:order]].flatten.reject(&:blank?)

    Contact.visible.where(statement).order(order_option)
  end

end