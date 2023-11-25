module Resolvers
  module Mutations
    class Login < GraphQL::Schema::Resolver
      type ObjectTypes::LoginResponse, null: false

      argument :email, String, required: true
      argument :password, String, required: true

      def resolve(email:, password:)
        user = User.find_by(email:)
        if user&.authenticate(password)
          jti = user.jti
          exp = (Time.now + 1.hour).to_i
          token = JwtToken.encode({ user_id: user.id, exp:, jti: })
          { token:, errors: [] }
        else
          { token: nil, errors: ['Invalid email or password'] }
        end
      rescue StandardError => e
        raise GraphQL::ExecutionError, e.message
      end
    end
  end
end
