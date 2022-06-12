class Tag < ApplicationRecord

  def self.search(search, keyword)
    if search != ""
      @tag = Tag.where(['name LIKE(?)', "%#{keyword}%"])
    else
      @tag = Tag.all
    end
  end

end
