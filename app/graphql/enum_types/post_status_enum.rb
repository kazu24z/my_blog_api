module EnumTypes
  class PostStatusEnum < BaseEnum
    description '記事公開ステータス'
    value 'draft', '下書き'
    value 'open', '公開'
  end
end
