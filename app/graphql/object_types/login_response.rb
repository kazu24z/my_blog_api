module ObjectTypes
  class LoginResponse < Types::BaseObject
    field :token, String, null: true
    field :errors, [String], null: true
  end
end
