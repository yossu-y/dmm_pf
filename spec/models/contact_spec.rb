require "rails_helper"
  RSpec.describe "Contactモデルのテスト", type: :model do
    describe "バリテーションのテスト" do
      let(:user) { FactoryBot.create(:user) }
      let!(:contact) { build(:contact, user_id: user.id) }

      subject { test_contact.valid? }
      let(:test_contact) { contact }

      context "nameカラム" do
        it "空欄でないこと" do
          test_contact.name = ""
          is_expected.to eq false;
        end
        it "50文字以下であること" do
          contact.name = Faker::Lorem.characters(number:51)
          expect(contact.valid?).to eq false;
        end
      end

      context "emailカラム" do
        it "メールアドレスがない場合" do
          test_contact.email = ""
          is_expected.to eq false;
        end
      end

      context "messageカラム" do
        it "空欄でないこと" do
          test_contact.message = ""
          is_expected.to eq false;
        end

        it "500文字以内であること" do
          contact.message = Faker::Lorem.characters(number:501)
          expect(contact.valid?).to eq false;
        end
      end
    end

    describe "アソシエーションのテスト" do

      context "userモデルの関係" do
        it "N:1となっている" do
          expect(Contact.reflect_on_association(:user).macro).to eq :belongs_to
        end
      end

    end

  end