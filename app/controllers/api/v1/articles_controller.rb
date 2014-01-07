module Api
  module V1
    class ArticlesController < SignedInController
      respond_to :json

      def index
        @articles = Article.all
      end

    end
  end
end