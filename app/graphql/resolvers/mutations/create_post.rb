module Resolvers
  module Mutations
    class CreatePost < GraphQL::Schema::Resolver
      type ObjectTypes::Post, null: false

      argument :params, InputTypes::Post, required: true

      def resolve(params:)
        # まだ認証機能無い+現状自分＝adminしかユーザーは想定していないため一旦ベタ書き
        ::Post.create!({ **params, user_id: 1, post_date: DateTime.current })
      rescue StandardError => e
        raise GraphQL::ExecutionError, e.message
      end
    end
  end
end
