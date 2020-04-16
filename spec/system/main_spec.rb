require 'rails_helper'

describe 'ユーザー権限のテスト'  do
  let!(:user) { create(:user) }
  let!(:portrait) { create(:portrait, user: user) }
  let!(:memory) { create(:memory, portrait: portrait) }
  describe 'ログインしていない場合' do
    context '投稿関連のURLにアクセス' do
      it 'アルバム一覧画面に遷移できない' do
        visit portraits_path
        expect(current_path).to eq('/users/sign_in')
      end
      it 'アルバム編集画面に遷移できない' do
        visit edit_portrait_path(portrait.id)
        expect(current_path).to eq('/users/sign_in')
      end
      it 'アルバム詳細画面に遷移できない' do
        visit portrait_path(portrait.id)
        expect(current_path).to eq('/users/sign_in')
      end
    end
  end
  describe 'ログインしていない場合にユーザー関連のURLにアクセス' do
    context 'ユーザー関連のURLにアクセス' do
      it 'ユーザー一覧画面に遷移できない' do
        visit users_path
        expect(current_path).to eq('/users/sign_in')
      end
      it 'ユーザー編集画面に遷移できない' do
        visit edit_user_path(user.id)
        expect(current_path).to eq('/users/sign_in')
      end
      it 'ユーザー詳細画面に遷移できない' do
        visit user_path(user.id)
        expect(current_path).to eq('/users/sign_in')
      end
    end
  end
  describe 'ログインしていない場合にユーザー関連のURLにアクセス' do
    context '思い出関連のURLにアクセス' do
      it '思い出編集画面に遷移できない' do
        visit edit_portrait_memory_path(portrait.id,memory.id)
        expect(current_path).to eq('/users/sign_in')
      end
      it '思い出詳細画面に遷移できない' do
        visit portrait_memory_path(portrait.id,memory.id)
        expect(current_path).to eq('/users/sign_in')
      end
    end
  end
end