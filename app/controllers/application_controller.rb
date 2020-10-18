class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :set_action_cable_identifier

  private

  def set_action_cable_identifier
    cookies.encrypted[:session_id] = session.id
  end
end
