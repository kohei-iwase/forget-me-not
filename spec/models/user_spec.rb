require 'rails_helper'

RSpec.describe 'Userモデルのテスト', type: :model do
  # 名前が空欄で登録できない→名前を空欄で登録したらfalse
  # バリデーションしていない状態で失敗→設定したら成功
  # 登録できるかできないか 登録できたら失敗
  # エラーメッセージがなければ失敗

  describe 'バリデーションのテスト' do
    subject { test_user.valid? }

    let(:user) { build(:user) }

    context 'nameカラム' do
      let(:test_user) { user }

      it '空欄でないこと' do
        test_user.name = ''
        is_expected.to eq false
      end
      it '2文字以上であること' do
        test_user.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '30文字以下であること' do
        test_user.name = Faker::Lorem.characters(number: 31)
        is_expected.to eq false
      end
    end

    context 'introductionカラム' do
      let(:test_user) { user }

      it '200文字以下であること' do
        test_user.introduction = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'portraitモデルとの関係' do
      it '1:Nとなっている' do
        expect(User.reflect_on_association(:portraits).macro).to eq :has_many
      end
    end
  end
end
