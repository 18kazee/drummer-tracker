class PagesController < ApplicationController
  include HighVoltage::StaticPage

  skip_before_action :require_login
  layout 'no_header_footer'

  def privacy; end
end
