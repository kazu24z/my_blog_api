module Resolvers
  module Queries
    class GetPost < GraphQL::Schema::Resolver
      type ObjectTypes::Post, null: false

      argument :user_id, ID, required: true
      argument :post_id, ID, required: true

      def resolve(user_id:, post_id:)
        user = ::User.find(user_id)
        post = user.posts.find(post_id)
      rescue StandardError => e
        raise GraphQL::ExecutionError, e.message
      end
    end
  end
end
