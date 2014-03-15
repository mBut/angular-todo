class TemplatesController < ActionController::Base
  def template
    render :template => 'templates/' + params[:path], :layout => nil
  end
end