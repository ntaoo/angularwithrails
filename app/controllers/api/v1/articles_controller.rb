module Api
  module V1
    class ArticlesController < ApplicationController
      respond_to :json

      def index
        @articles = Article.all
      end

    end
  end
end