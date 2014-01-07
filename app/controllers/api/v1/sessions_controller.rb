module Api
  module V1
    class SessionsController < SignedInController

      skip_before_filter :require_login, :except => [:destroy]

      def create
        if login(session_params['email'], session_params['password'])
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
              error_message: 'Email or password was invalid.'
            }
          )
        end
      end

      def destroy
        logout
        render(
          status: 200,
          json: {}
        )
      end

      def session_params
        params.require(:session).permit(:email, :password)
      end
    end

  end
end