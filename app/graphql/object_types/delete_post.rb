module ObjectTypes
  class DeletePost < Types::BaseObject
    field :post_id, ID, null: false
    field :success, Boolean, null: false, description: '削除に成功したかどうか'
    field :message, String, null: true, description: '削除成功時の追加情報'
  end
end
