require 'rails_helper'

describe 'トップページのテスト' do
  let(:user) { create(:user) }
  let!(:portrait) { create(:portrait, user: user) }
  let!(:memory) { create(:memory, portrait: portrait) }

  before do
    visit homes_top_path
  end

  describe 'ボディ部分のテスト' do
    context 'ヘッダー表示の確認' do
      it 'TOPページへのリンクが表示される' do
        expect(page).to have_css('img'), href: homes_top_path
      end
      it 'アバウトページが表示される' do
        about_link = find_all('a')[1].native.inner_text
        expect(about_link).to match(/ワスレナグサについて/i)
        expect(page).to have_link about_link, href: homes_about_path
      end
      it '新規登録リンクが表示される' do
        signup_link = find_all('a')[4].native.inner_text
        expect(signup_link).to match(/新規登録/i)
        expect(page).to have_link signup_link, href: new_user_registration_path
      end
      it 'ログインリンクが表示される' do
        login_link = find_all('a')[5].native.inner_text
        expect(login_link).to match(/ログイン/i)
        expect(page).to have_link login_link, href: new_user_session_path
      end
    end

    context 'ログインしている場合の挙動を確認' do
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'サインイン'
        visit root_path
      end

      it 'マイページをクリックしたらマイページへ遷移する' do
        mypage_link = find_all('a')[2].native.inner_text
        click_link mypage_link
        expect(page).to have_content(user.name)
      end
      it 'アルバムを作るをクリックしたらアルバム投稿画面に遷移する' do
        album_link = find_all('a')[3].native.inner_text
        click_link album_link
        expect(page).to have_content 'アルバム'
      end
      it 'タイムラインをクリックしたらタイムラインに遷移する' do
        timeline_link = find_all('a')[4].native.inner_text
        click_link timeline_link
        expect(page).to have_content 'タイムライン'
      end
      it 'ユーザー一覧ページに遷移する' do
        users_link = find_all('a')[5].native.inner_text
        click_link users_link
        expect(page).to have_content 'ユーザー一覧'
      end
      it 'アルバム一覧に遷移する' do
        albums_link = find_all('a')[6].native.inner_text
        click_link albums_link
        expect(page).to have_content 'アルバム一覧'
      end
    end

    context 'ログインしていない場合の挙動を確認' do
      it 'ログインボタンをクリックしたらログイン画面へ遷移する' do
        click_on 'ログイン', match: :first
        expect(current_path).to eq(new_user_session_path)
      end
      it '新規登録ボタンをクリックしたら新規登録画面に遷移する' do
        click_on '新規登録', match: :first
        expect(current_path).to eq(new_user_registration_path)
      end
    end
  end
end
