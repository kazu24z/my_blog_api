# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_post, resolver: Resolvers::Mutations::CreatePost
  end
end
