require 'rails_helper'

describe 'ユーザー権限のテスト'  do
  let(:user) { create(:user) }
  let!(:portrait) { create(:portrait, user: user) }
  let!(:memory) { create(:memory, portrait: portrait) }
  let!(:anniversary) { create(:anniversary, portrait: portrait, user: user) }
    describe 'ログインしていない場合' do
      context 'アルバム関連のURLにアクセス' do
        it 'アルバム一覧画面に遷移できる' do
          visit portraits_path
          expect(current_path).to eq('/portraits')
          expect(page).to have_no_button '献花する'
        end
        it 'アルバム詳細画面に遷移できる' do
          visit portrait_path(portrait.id)
          expect(current_path).to eq('/portraits/' + portrait.id.to_s)
          expect(page).to have_no_button '献花する'
        end
        it 'アルバム編集画面に遷移できない' do
          visit edit_portrait_path(portrait.id)
          expect(current_path).to eq('/users/sign_in')
        end
        it 'アルバム投稿画面に遷移できない' do
          visit new_portrait_path
          expect(current_path).to eq('/users/sign_in')
        end
      end
    end
    describe 'ログインしていない場合にユーザー関連のURLにアクセス' do
      context 'ユーザー関連のURLにアクセス' do
        it 'ユーザー一覧画面に遷移できる' do
          visit users_path
          expect(current_path).to eq('/users')
          expect(page).to have_no_button 'フォローする'
        end
        it 'ユーザー詳細画面に遷移できる' do
          visit user_path(user)
          expect(current_path).to eq('/users/' + user.id.to_s)
          expect(page).to have_no_button 'フォローする'
        end
        it 'ユーザー編集画面に遷移できない' do
          visit edit_user_path(user)
          expect(current_path).to eq('/users/sign_in')
        end
        it 'タイムラインに遷移できない' do
          visit timelines_user_path(user)
          expect(current_path).to eq('/users/sign_in')
        end
      end
    end
    describe 'ログインしていない場合に思い出関連のURLにアクセス' do
      context '思い出関連のURLにアクセス' do
        it '思い出詳細画面に遷移できる' do
          visit portrait_memory_path(portrait.id,memory.id)
          expect(current_path).to eq('/portraits/' + portrait.id.to_s + '/memories/' + portrait.id.to_s)
          expect(page).to have_no_button '献花する'
        end
        it '思い出編集画面に遷移できない' do
          visit edit_portrait_memory_path(portrait.id,memory.id)
          expect(current_path).to eq('/users/sign_in')
        end
      end
    end
    describe 'ログインしていない場合に供養日関連のURLにアクセス' do
      context '供養日関連のURLにアクセス' do
        it '供養日編集画面に遷移できない' do
          visit edit_portrait_anniversary_path(portrait,anniversary)
          expect(current_path).to eq('/users/sign_in')
        end
        it '供養日一覧画面に遷移できない' do
          visit portrait_anniversaries_path(portrait)
          expect(current_path).to eq('/users/sign_in')
        end
      end
    end

    describe 'ログインしていない場合の検索機能' do
      context '検索機能ボタンをクリック' do
        it 'ペット名を選んで検索結果が表示される' do
          visit root_path
          select 'ペット名'
          select '部分一致'
          click_on'検索'
          expect(page).to have_content '「」の検索結果'
        end
        it 'ペット種類を選んで検索結果が表示される' do
          visit root_path
          select 'ペット種類'
          select '部分一致'
          click_on'検索'
          expect(page).to have_content '「」の検索結果'
        end
        it 'ユーザー名を選んで検索結果が表示される' do
          visit root_path
          select 'ユーザー名'
          select '部分一致'
          click_on'検索'
          expect(page).to have_content '「」の検索結果'
        end
        it 'ペット名を選んで検索結果が表示される' do
          visit root_path
          select '思い出'
          select '部分一致'
          click_on'検索'
          expect(page).to have_content '「」の検索結果'
        end
      end
    end
end