require 'rails_helper'

describe 'サイドバーのテスト' do
  let(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:portrait) { create(:portrait, user: user) }
  let!(:portrait2) { create(:portrait, user: user2) }
  let!(:memory) { create(:memory, portrait: portrait) }
  let!(:memory2) { create(:memory, portrait: portrait2) }
  let!(:anniversary) { create(:anniversary, user: user, portrait: portrait) }
  let!(:anniversary2) { create(:anniversary, user: user2, portrait: portrait2) }

  describe 'ログインしていない場合' do
    before do
      visit root_path
    end
    context 'サイドバーの表示を確認' do
      subject { page }
      it 'ユーザー名が表示されない' do
        expect(page).to have_no_content user.name
      end
      it '供養日通知が表示されない' do
        expect(page).to have_no_content '供養日通知'
      end
      it '検索フォームが表示される' do
        expect(page).to have_content '検索フォーム'
      end
    end
    context '機能を確認' do
      it 'ペット名を選んで検索結果が表示される' do
        visit root_path
        select 'ペット名'
        select '部分一致'
        fill_in 'search[content]', with: portrait.name
        click_on '検索'
        expect(page).to have_content portrait.name
      end
      it 'ペット種類を選んで検索結果が表示される' do
        visit root_path
        select 'ペット種類'
        select '部分一致'
        fill_in 'search[content]', with: 'ねこ'
        click_on '検索'
        expect(page).to have_content 'ねこ'
      end
      it 'ユーザー名を選んで検索結果が表示される' do
        visit root_path
        select 'ユーザー名'
        select '部分一致'
        fill_in 'search[content]', with: user.name
        click_on '検索'
        expect(page).to have_content user.name
      end
      it 'ペット名を選んで検索結果が表示される' do
        visit root_path
        select '思い出'
        select '部分一致'
        fill_in 'search[content]', with: memory.title
        click_on '検索'
        expect(page).to have_content memory.title
      end
    end
  end
  describe 'ログインしている場合' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'サインイン'
      visit root_path
    end
    context 'サイドバーの表示を確認' do
      subject { page }
      it 'ユーザー名が表示される' do
        expect(page).to have_content user.name
      end
      it 'フォロイー数が表示される' do
        expect(page).to have_content 'following'
      end
      it 'フォロワー数が表示される' do
        expect(page).to have_content 'followers'
      end
      it 'プロフィール編集ボタンが表示される' do
        expect(page).to have_content 'プロフィール編集'
      end
      it '供養日通知が表示される' do
        expect(page).to have_content '供養日通知'
      end
      it '検索フォームが表示される' do
        expect(page).to have_content '検索フォーム'
      end
    end
    context 'サイドバーの機能を確認' do
      subject { page }
      it 'ユーザー名をクリック、ユーザー詳細に遷移される' do
        click_on user.name
        expect(current_path).to eq '/users/' + user.id.to_s
      end
      it 'プロフィール編集をクリック、ユーザー編集画面に遷移される' do
        click_on 'プロフィール編集'
        expect(current_path).to eq '/users/' + user.id.to_s + '/edit'
      end
      it 'ペット名での検索機能の確認' do
        visit root_path
        select 'ペット名'
        select '部分一致'
        fill_in 'search[content]', with: portrait.name
        click_on '検索'
        expect(page).to have_content portrait.name
      end
      it 'ペット種類での検索機能の確認' do
        visit root_path
        select 'ペット種類'
        select '部分一致'
        fill_in 'search[content]', with: 'ねこ'
        click_on '検索'
        expect(page).to have_content 'ねこ'
      end
      it 'ユーザー名での検索機能の確認' do
        visit root_path
        select 'ユーザー名'
        select '部分一致'
        fill_in 'search[content]', with: user.name
        click_on '検索'
        expect(page).to have_content user.name
      end
      it '思い出での検索機能の確認' do
        visit root_path
        select '思い出'
        select '部分一致'
        fill_in 'search[content]', with: memory.title
        click_on '検索'
        expect(page).to have_content memory.title
      end
    end
  end
end
