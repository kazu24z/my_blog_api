module InputTypes
  class Post < Types::BaseInputObject
    description '記事投稿'

    argument :status, EnumTypes::PostStatusEnum, required: true, description: '下書きor公開'
    argument :title, String, required: false, description: 'タイトル'
    argument :content, String, required: false, description: '本文'
  end
end
