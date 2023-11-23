module Resolvers
  module Mutations
    class Logout < GraphQL::Schema::Resolver
      type ObjectTypes::LogoutResponse, null: false

      def resolve
        user = context[:current_user]
        raise GraphQL::ExecutionError, "User not login" unless user

        # jtiを更新し、現在のトークンを無効化
        user.update(jti: SecureRandom.uuid)
        { message: "Successfully logout" }
      end
    end
  end
end
