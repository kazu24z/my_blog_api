module InputTypes
  class EditPost < Types::BaseInputObject
    description '記事編集'

    argument :status, EnumTypes::PostStatusEnum, required: false, description: '下書きor公開'
    argument :title, String, required: false, description: 'タイトル'
    argument :content, String, required: false, description: '本文'
  end
end
