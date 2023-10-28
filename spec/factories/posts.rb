FactoryBot.define do
  factory :post do
    title { "テストタイトル" }
    content { "# 見出し1  ## 見出し2 ### 見出し3" }
    status { "draft" }
    post_date { DateTime.current }
    # リレーションUser
    user
  end
end
