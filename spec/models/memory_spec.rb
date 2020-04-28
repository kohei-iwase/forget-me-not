require 'rails_helper'

RSpec.describe '思い出モデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    let(:user) { create(:user) }
    let!(:portrait) { build(:portrait, user_id: user.id) }
    let!(:memory) { build(:memory, portrait_id: portrait.id) }

    context 'titleカラム' do
      it '空欄でないこと' do
        memory.title = ''
        expect(memory.valid?).to eq false
      end
    end
    context '本文カラム' do
      it '200文字以下であること' do
        memory.memory = Faker::Lorem.characters(number: 201)
        expect(memory.valid?).to eq false
      end
    end
  end
  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(Memory.reflect_on_association(:portrait).macro).to eq :belongs_to
      end
    end

    context 'Flowerモデルとの関係' do
      it '1:Nとなっている' do
        expect(Memory.reflect_on_association(:flowers).macro).to eq :has_many
      end
    end
  end
end
