module Resolvers
  module Mutations
    class DeletePost < GraphQL::Schema::Resolver
      type ObjectTypes::DeletePost, null: false

      argument :user_id, ID, required: true
      argument :post_id, ID, required: true

      def resolve(user_id:, post_id:)
        # まだ認証機能無い+現状自分＝adminしかユーザーは想定していないため一旦ベタ書き
        post = ::User.find(user_id).posts.find(post_id)

        post.destroy
        {
          post_id:,
          success: true,
          message: "post_id: #{post_id} was deleted successfully."
        }
      rescue ActiveRecord::RecordNotFound => e
        raise GraphQL::ExecutionError, "Post with ID #{post_id} not found."
      rescue StandardError => e
        raise GraphQL::ExecutionError, "Faild to delete the post: #{e.message}"
      end
    end
  end
end
