module Api
  module V1
    class SessionsController < SignedInController

      skip_before_filter :require_login, :except => [:destroy]

      #def new
      #  logout
      #end

      def create
        puts session_params['email']
        puts session_params['password']
        if login(session_params['email'], session_params['password'])
          render(
              status: 200,
              json: {
                  success: true,
                  info: "Signed In!",
                  data: {
                      user: {id: current_user.id, email: current_user.email}
                  }
              }
          )
        else
          render(
              status: 401,
              json: {
                  info: "Wrong email or password"
              }
          )
        end
      end

      def destroy
        logout
        #redirect_to sign_in_url, :notice => 'Signed out!'
      end

      def session_params
        params.require(:session).permit(:email, :password)
      end
    end

  end
end