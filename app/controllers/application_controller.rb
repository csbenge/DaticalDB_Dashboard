class ApplicationController < ActionController::Base

	rescue_from ActiveRecord::NoDatabaseError, :with => :database_not_found
	def database_not_found
		set_internal_database
		respond_to do |format|
			flash[:error] = 'Could not connect to Schema.'
			format.html { redirect_to schemas_url }
		end
	end

	def set_Schema_Connection(schema)
		begin
		  ActiveRecord::Base.establish_connection(
		    :adapter  => "#{schema.database_type}",
		    :host     => "#{schema.host}",
		    :port     => "#{schema.port}",
		    :username => "#{schema.username}",
		    :password => "#{schema.password}",
		    :database => "#{schema.name}"
		    )
	  	return 0
    rescue
      set_internal_database
      return 1
    end
	end

	# Login

	# Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

	# Returns the current logged-in user (if any).
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end

	# Confirms a logged-in user.
  def logged_in_user
    unless logged_in?
      redirect_to login_url
    end
  end

	# Logs in the given user.
  def log_in(user)
    session[:user_id] 	 = user.id
    session[:user_name]  = user.name
    session[:user_email] = user.email
  end

  # Logs out the current user.
  def log_out
    session.delete(:user_id)
    session.delete(:user_name)
    session.delete(:user_email)
    @current_user = nil
  end

  protected
  
  include SessionsHelper
  
  SESSION_TIMEOUT = 15            # in minutes
  
  def authorize
    unless User.find_by_name(session[:user_name])
      redirect_to login_url
      # redirect_to login_url, :alert => t(:session_login) 
    end
  end
	
end