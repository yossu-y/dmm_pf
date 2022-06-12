class Like < ApplicationRecord

  belongs_to :user
  belongs_to :article

  valodates_uniquness_of :article_id, scope: :user_id

end
