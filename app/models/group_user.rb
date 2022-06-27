class GroupUser < ApplicationRecord

  # リレーション
  belongs_to :user
  belongs_to :group

end
