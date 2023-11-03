module Resolvers
  module Mutations
    class EditPost < GraphQL::Schema::Resolver
      type ObjectTypes::Post, null: false

      argument :post_id, ID, required: true, description: '記事ID'
      argument :params, InputTypes::EditPost, required: true

      def resolve(post_id:, params:)
        target_post = ::Post.find(post_id)
        target_post.update!(params.to_h)
        target_post
      rescue StandardError => e
        raise GraphQL::ExecutionError, e.message
      end
    end
  end
end
