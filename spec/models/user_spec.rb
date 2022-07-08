require "rails_helper"
  RSpec.describe "Userモデルのテスト", type: :model do
    describe "バリテーションのテスト" do
      let(:user) { FactoryBot.create(:user) }
      let!(:user) { create(:user) }

      subject { test_user.valid? }
      let(:test_user) { user }

      context "nameカラム" do
        it "名前がない場合" do
          test_user.name = ""
          is_expected.to eq true;
        end
      end

      context "screen_nameカラム" do
        it "ニックネームがない場合" do
          test_user.screen_name = ""
          is_expected.to eq false;
        end
        it "ニックネームが30文字以下である" do
          user.screen_name = Faker::Lorem.characters(number:31)
          expect(user.valid?).to eq false;
        end

      end
    end
  end
