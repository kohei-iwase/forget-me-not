require 'rails_helper'

RSpec.describe 'anniversaryモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let!(:portrait) { build(:portrait, user_id: user.id) }
    let!(:anniversary) { build(:anniversary, portrait_id: portrait.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        anniversary.title = ''
        expect(anniversary.valid?).to eq false;
      end
    end
    context 'メモカラム' do
      it '200文字以下であること' do
        anniversary.memo = Faker::Lorem.characters(number:201)
        expect(anniversary.valid?).to eq false;
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Portraitモデルとの関係' do
      it 'N:1となっている' do
        expect(Portrait.reflect_on_association(:anniversary).macro).to eq :belongs_to
      end
    end
  end
end