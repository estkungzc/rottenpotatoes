class ApplicationController < ActionController::Base
    # the before_filter is deprecated and was last used in Rails 2.3.8 (very old),
    # you can use before_action instead.
    before_action :set_current_user
    protected # prevents method from being invoked by a route
    def set_current_user
      # we exploit the fact that the below query may return nil
      @current_user ||= Moviegoer.find_by(id: session[:user_id])
      redirect_to login_path and return unless @current_user
    end

    
end
