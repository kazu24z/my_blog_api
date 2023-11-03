# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_post, resolver: Resolvers::Mutations::CreatePost
    field :edit_post, resolver: Resolvers::Mutations::EditPost
    field :delete_post, resolver: Resolvers::Mutations::DeletePost
  end
end
