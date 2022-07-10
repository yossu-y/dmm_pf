require 'rails_helper'

  RSpec.describe "Groupモデルのテスト", type: :model do

    describe "バリテーションのテスト" do
      let(:user) { FactoryBot.create(:user) }
      let!(:group) { build(:group, user_ids: user.id) }

      subject { test_group.valid? }
      let(:test_group) { group }

      context "nameカラム" do
        it "空欄でないこと" do
          test_group.name = ""
          is_expected.to eq false;
        end
        it "50文字以下であること" do
          group.name = Faker::Lorem.characters(number:51)
          expect(group.valid?).to eq false;
        end
      end

      context "introductionカラム" do
        it "空欄でないこと" do
          test_group.introduction = ""
          is_expected.to eq false;
        end

        it "800文字以下であること" do
          group.introduction = Faker::Lorem.characters(number:801)
          expect(group.valid?).to eq false;
        end

      end

      describe "アソシエーションのテスト" do
        context "userモデルとの関係" do
          it "N:1となっている" do
            expect(Group.reflect_on_association(:users).macro).to eq :has_many
          end
        end

        context "messageモデルとの関係" do
          it "1:Nとなっている" do
            expect(Group.reflect_on_association(:messages).macro).to eq :has_many
          end
        end
      end

    end

  end