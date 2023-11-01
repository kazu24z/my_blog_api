module Resolvers
  module Queries
    class GetPosts < GraphQL::Schema::Resolver
      type [ObjectTypes::Post], null: false

      argument :user_id, ID, required: true

      def resolve(user_id:)
        user = ::User.find(user_id)
        posts = user.posts
      rescue StandardError => e
        raise GraphQL::ExecutionError, e.message
      end
    end
  end
end
