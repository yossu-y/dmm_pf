require "rails_helper"

RSpec.describe "Commentモデルのテスト", type: :model do

  describe "バリデーションのテスト" do
    let(:user) { FactoryBot.create(:user) }
    let!(:comment) { build(:comment, user_id: user.id) }

    subject { test_comment.valid? }
    let(:test_comment) { comment }

    context "commentカラム" do
      it "空欄でないこと" do
        test_comment.comment = ""
        is_expected.to eq false;
      end

      it "140文字以内であること" do
        comment.comment = Faker::Lorem.characters(number:141)
        expect(comment.valid?).to eq false;
      end
    end
  end

  describe "アソシエーション" do
    it "1:Nとなっている" do
      expect(Comment.reflect_on_association(:user).macro).to eq :belongs_to
    end
    it "1:Nとなっている" do
      expect(Comment.reflect_on_association(:article).macro).to eq :belongs_to
    end
    it "N:1となっている" do
      expect(Comment.reflect_on_association(:notifications).macro).to eq :has_many
    end
  end

end