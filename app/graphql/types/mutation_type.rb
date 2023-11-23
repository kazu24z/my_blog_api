# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :login, resolver: Resolvers::Mutations::Login
    field :logout, resolver: Resolvers::Mutations::Logout
    field :create_post, resolver: Resolvers::Mutations::CreatePost
    field :edit_post, resolver: Resolvers::Mutations::EditPost
    field :delete_post, resolver: Resolvers::Mutations::DeletePost
  end
end
