class UserTokenController < Knock::AuthTokenController
  def create
      render json: {
        jwt: auth_token.token, 
        admin: User.find_by(email: params[:auth][:email]).admin
      }, 
      status: :created
    end
end
