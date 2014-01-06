module Api
  module V1
    class TouchController < ApplicationController
      respond_to :json

      # just for setting cookie
      def index
        render :json => { info: '', status: :success }
      end
    end
  end
end
