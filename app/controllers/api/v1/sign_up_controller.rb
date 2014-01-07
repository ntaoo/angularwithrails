module Api
  module V1
    class SignUpController < ApplicationController
      respond_to :json

      def create
        user = User.new(sign_up_params)
        if user.save
          auto_login(user)
          render(
            status: 200,
            json: {
                currentUser: {id: current_user.id, email: current_user.email}
            }
          )
        else
          render(
            status: 422,
            json: {
              errors: user.errors
            }
          )
        end
      end

      private
      def sign_up_params
        params.require(:sign_up).permit(:email, :password)
      end
    end
  end
end
