require 'rails_helper'

  RSpec.describe "Groupモデルのテスト", type: :model do
    describe "バリテーションのテスト" do
      let(:user) { FactoryBot.create(:user) }
      let!(:group) { build(:group, user_id: user.id) }

      subject { test_group.valid? }
      let(:test_group) { group }
      
      centext "nameカラム" do
        it "空欄でないこと" do
          test_group.name = ""
          is_expected.to eq true;
        end
        
        it "50文字以下であること" do
          group.name = Faker::Lorem.character(number:51)
          expect(group.valid?).to eq true;
        end
      end

    end

  end