require "rails_helper"

RSpec.describe "Messageモデルのテスト", type: :model do
  describe "バリテーションのテスト" do
    let(:user) { FactoryBot.create(:user) }
    let!(:message) { build(:message, user_id: user.id) }

    subject { test_message.valid? }
    let(:test_message) { message }

    context "messageカラム" do
      it "空欄でないこと" do
        test_message.message = ""
        is_expected.to eq false;
      end

      it "500文字以内であること" do
        message.message = Faker::Lorem.characters(number:501)
        expect(message.valid?).to eq false;
      end
    end
  end

  describe "アソシエーション" do
    it "1:Nになっている" do
      expect(Message.reflect_on_association(:user).macro).to eq :belongs_to
    end

    it "1:Nになっている" do
      expect(Message.reflect_on_association(:group).macro).to eq :belongs_to
    end
  end
end