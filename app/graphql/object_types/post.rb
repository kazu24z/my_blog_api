module ObjectTypes
  class Post < Types::BaseObject
    field :post_id, ID, null: false
    field :user_id, ID, null: false
    field :status, EnumTypes::PostStatusEnum, null: false, description: '公開ステータス'
    field :title, String
    field :content, String
    field :post_date, GraphQL::Types::ISO8601DateTime
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
