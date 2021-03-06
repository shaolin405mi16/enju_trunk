class Devise::SessionsController < ApplicationController
  prepend_before_filter :require_no_authentication, :only => [ :new, :create ]
  prepend_before_filter :allow_params_authentication!, :only => :create
  prepend_before_filter :clear_locale, :only => [:create]
  include Devise::Controllers::InternalHelpers
  layout :select_layout

  # GET /resource/sign_in
  def new
    resource = build_resource
    clean_up_passwords(resource)
    if params[:opac]
      respond_with_navigational(resource, stub_options(resource)){render  :template => 'opac/devise/sessions/new'} 
    else
      respond_with_navigational(resource, stub_options(resource)){ render_with_scope :new }
    end
  end

  # POST /resource/sign_in
  def create
    resource = warden.authenticate!(:scope => resource_name, :recall => "#{controller_path}#new")
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    sign_in(resource_name, resource)

    pp '@@@@ 3 params'
    pp params

    if params[:opac]
      respond_with resource, :location => opac_path
    else
      respond_with resource, :location => after_sign_in_path_for(resource)
    end
  end

  # DELETE /resource/sign_out
  def destroy
    signed_in = signed_in?(resource_name)
    if params[:opac]
      redirect_path = opac_path
    else
      redirect_path = after_sign_out_path_for(resource_name)
    end
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :signed_out if signed_in

    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.any(*navigational_formats) { redirect_to redirect_path }
      format.all do
        method = "to_#{request_format}"
        text = {}.respond_to?(method) ? {}.send(method) : ""
        render :text => text, :status => :ok
      end
    end
  end

  def select_layout
    if params[:opac]
      "opac"
    else
      "application"
    end
  end

  protected

  def stub_options(resource)
    methods = resource_class.authentication_keys.dup
    methods = methods.keys if methods.is_a?(Hash)
    methods << :password if resource.respond_to?(:password)
    { :methods => methods, :only => [:password] }
  end

  private
  def clear_locale
    session[:locale] = nil
  end
end

