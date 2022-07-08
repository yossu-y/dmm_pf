require 'rails_helper'

RSpec.describe "Articleモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    # factoriesで作成したダミーデータを使用します。
    let(:user) { FactoryBot.create(:user) }
    let!(:article) { build(:article, user_id: user.id) }

    # test_articleを作成し、空欄での登録ができるか確認します。
    subject { test_article.valid? }
    let(:test_article) { article }

    context "titleカラム" do
      it "空欄でないこと" do
        test_article.title = ''
        is_expected.to eq true;
      end
      it "50文字以下であること" do
        article.title = Faker::Lorem.characters(number:51)
        expect(article.valid?).to eq true;
      end
    end

    context "bodyカラム" do
      it "空欄でないこと" do
        test_article.body = ''
        is_expected.to eq true;
      end
      it "2000文字以下であること" do
        article.body = Faker::Lorem.characters(number:2001)
        expect(article.valid?).to eq true;
      end
    end

  end

  describe "アソシエーションのテスト" do
    context "userモデルとの関係" do
      it "N:1となっている" do
        expect(Article.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    # has_manyの関係性で記述するのもありです。
    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(Article.reflect_on_association(:comments).macro).to eq :has_many
      end
    end

  end

end
