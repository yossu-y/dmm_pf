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

      context "emailカラム" do
        it "メールアドレスがない場合" do
          test_user.email = ""
          is_expected.to eq false;
        end
      end

      context "introductionカラム" do
        it "自己紹介が350文字以下である" do
          user.introduction = Faker::Lorem.characters(number:351)
          expect(user.valid?).to eq false;
        end
      end

    end

    describe "バリテーションのテスト" do
      context "Commentモデルとの関係" do
        it "1:Nとなっている" do
          expect(User.reflect_on_association(:comments).macro).to eq :has_many
        end
      end

      context "Articleモデルとの関係" do
        it "1:Nとなっている" do
          expect(User.reflect_on_association(:articles).macro).to eq :has_many
        end
      end

      context "Likeモデルとの関係" do
        it "1:Nとなっている" do
          expect(User.reflect_on_association(:likes).macro).to eq :has_many
        end
      end

      context "Group_Usersモデルとの関係" do
        it "1:Nとなっている" do
          expect(User.reflect_on_association(:group_users).macro).to eq :has_many
        end
      end

      context "Groupモデルとの関係" do
        it "1:Nとなっている" do
          expect(User.reflect_on_association(:groups).macro).to eq :has_many
        end
      end

      context "Messageモデルとの関係" do
        it "1:Nとなっている" do
          expect(User.reflect_on_association(:messages).macro).to eq :has_many
        end
      end

      context "Notificationsモデルとの関係" do
        it "1:Nとなっている" do
          expect(User.reflect_on_association(:notifications).macro).to eq :has_many
        end
      end

      context "Contactsモデルとの関係" do
        it "1:Nとなっている" do
          expect(User.reflect_on_association(:group_users).macro).to eq :has_many
        end
      end
    end

  end

