class ApplicationController < ActionController::API
  include Knock::Authenticable

  def authenticate_admin
    # unless my user is an admin, show unauthorized
    unless current_user.admin
      render json: {message: "Unauthorized"}, status: :unauthorized
    end
  end

  # def authenticate_user
  #   unless current_user
  #     render json: {message: "You must be logged in to do that"}, status: :unauthorized
  #   end
  # end

end
