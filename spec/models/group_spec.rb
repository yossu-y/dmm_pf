require 'rails_helper'

  RSpec.describe "Groupモデルのテスト", type: :model do
    describe "バリテーションのテスト" do
      let(:user) { FactoryBot.create(:user) }
      let!(:group) { build(:group, user_id: user.id) }

      subject { test_group.valid? }
      let(:test_group) { group }


    end

  end