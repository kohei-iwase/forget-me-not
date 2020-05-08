require 'rails_helper'

RSpec.describe 'アルバムモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let!(:portrait) { build(:portrait, user_id: user.id) }

    context 'nameカラム' do
      it '空欄でないこと' do
        portrait.name = ''
        expect(portrait.valid?).to eq false
      end
    end

    context '本文カラム' do
      it '200文字以下であること' do
        portrait.more_about_me = Faker::Lorem.characters(number: 201)
        expect(portrait.valid?).to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Portrait.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context 'Memoryモデルとの関係' do
      it '1:Nとなっている' do
        expect(Portrait.reflect_on_association(:memories).macro).to eq :has_many
      end
    end

    context 'Bouquetモデルとの関係' do
      it '1:Nとなっている' do
        expect(Portrait.reflect_on_association(:bouquets).macro).to eq :has_many
      end
    end
  end
end
