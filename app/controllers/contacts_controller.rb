class ContactsController < ApplicationController

  helper :custom_fields
  helper :attachments
  include AttachmentsHelper
  helper :queries
  include QueriesHelper
  helper :sort
  include SortHelper

  before_filter :find_contact, :only => [:edit, :update, :destroy, :show]
  before_filter :find_optional_project

  def index

    @query = ContactQuery.build_from_params(params, :project => @project, :name => '_')

    sort_init(@query.sort_criteria.empty? ? [['name', 'desc']] : @query.sort_criteria)
    sort_update(@query.sortable_columns)
    scope = contact_scope(:order => sort_clause).
        includes(:project)

        @entry_count = scope.count
        @entry_pages = Paginator.new @entry_count, per_page_option, params['page']
        @entries = scope.offset(@entry_pages.offset).limit(@entry_pages.per_page).to_a

        render :layout => !request.xhr?
  end

  def new
    @contact = Contact.new
    @contact.safe_attributes = params[:contact]
  end

  def create
    @contact = Contact.new
    @contact.safe_attributes = params[:contact]
    @contact.save_attachments(params[:attachments])
    if @contact.save
      render_attachment_warning_if_needed(@contact)
      flash[:notice] = l(:notice_successful_create)
      redirect_to project_contacts_path(@project)
    else
      flash[:alert] = l(:notice_params_needed)
      render :action => 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    @contact.safe_attributes = params[:contact]
    @contact.save_attachments(params[:attachments])
    if @contact.update_attributes(params[:contact])
      render_attachment_warning_if_needed(@contact)
      flash[:notice] = l(:notice_successful_update)
      redirect_to project_contacts_path(@project)
    else
      render :action => 'edit', project_id: @contact.project_id
    end
  end

  def destroy
    @contact.destroy
    flash[:notice] = l(:notice_successful_delete)
    redirect_to project_contacts_path(@project)
  end

  private

  def find_contact
    @contact = Contact.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render_404
  end

  def contact_scope(options={})
    scope = @query.results_scope(options)
    scope
  end
end
