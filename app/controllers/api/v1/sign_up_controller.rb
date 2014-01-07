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
              success: true,
              info: "Signed Up!",
              data: {
                user: {id: user.id, email: user.email}
              }
            }
          )
        else
          render(
            status: :unprocessable_entity,
            json: {
              success: false,
              info: user.errors, data: {}
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
