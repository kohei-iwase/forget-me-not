require 'rails_helper'

describe 'ヘッダーのテスト' do
  describe 'ログインしていない場合' do
    before do
      visit root_path
    end
    context 'ヘッダーの表示を確認' do
      subject { page }
      it 'タイトルが表示される' do
        is_expected.to have_content 'ワスレナグサ'
      end
      it 'ロゴイメージが表示される' do
        is_expected.to have_css('img')

      end
      it 'ワスレナグサについて（about)リンクが表示される' do
        about_link = find_all('a')[1].native.inner_text
        expect(about_link).to match('ワスレナグサについて')
      end
      it 'ユーザー一覧リンクが表示される' do
        about_link = find_all('a')[2].native.inner_text
        expect(about_link).to match('ユーザー一覧')
      end
      it 'アルバム一覧リンクが表示される' do
        about_link = find_all('a')[3].native.inner_text
        expect(about_link).to match('アルバム一覧')
      end
      it '新規登録リンクが表示される' do
        signup_link = find_all('a')[4].native.inner_text
        expect(signup_link).to match('新規登録')
      end
      it 'loginリンクが表示される' do
        login_link = find_all('a')[5].native.inner_text
        expect(login_link).to match('ログイン')

      end
    end
    context 'ヘッダーのリンクを確認' do
      subject { current_path }
      it 'ロゴをクリックするとHome画面に遷移する' do
        home_link = find_all('a')[0].native.inner_text
        click_link home_link
        is_expected.to eq(homes_top_path)
      end
      it 'aboutページに遷移する' do
        about_link = find_all('a')[1].native.inner_text
        about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link about_link
        is_expected.to eq(homes_about_path)
      end
      it 'ユーザー一覧ページに遷移する' do
        about_link = find_all('a')[2].native.inner_text
        about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link about_link
        is_expected.to eq(users_path)
      end
      it 'アルバム一覧に遷移する' do
        about_link = find_all('a')[3].native.inner_text
        about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link about_link
        is_expected.to eq(portraits_path)
      end
      it '新規登録画面に遷移する' do
        signup_link = find_all('a')[4].native.inner_text
        signup_link = signup_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link signup_link, match: :first
        is_expected.to eq(new_user_registration_path)
      end
      it 'ログイン画面に遷移する' do
        login_link = find_all('a')[5].native.inner_text
        login_link = login_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link login_link, match: :first
        is_expected.to eq(new_user_session_path)
      end
    end
  end

  describe 'ログインしている場合' do
    let(:user) { create(:user) }
    let!(:portrait) { create(:portrait, user: user) }
    let!(:memory) { create(:memory, portrait: portrait) }

    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'サインイン'
    end
    context 'ヘッダーの表示を確認' do
      subject { page }
      it 'タイトルが表示される' do
        is_expected.to have_content 'ワスレナグサ'
      end
      it 'Aboutページへのリンクが表示される' do
        home_link = find_all('a')[1].native.inner_text
        expect(home_link).to match("ワスレナグサについて")
      end
      it 'マイアルバムへのリンクが表示される' do
        album_link = find_all('a')[2].native.inner_text
        expect(album_link).to match("マイアルバム")
      end
      it 'アルバム作成へのリンクが表示される' do
        new_album_link = find_all('a')[3].native.inner_text
        expect(new_album_link).to match("アルバムを作る")
      end
      it 'タイムラインへのリンクが表示される' do
        timelines_link = find_all('a')[4].native.inner_text
        expect(timelines_link).to match("タイムライン")
      end
      it 'ユーザー一覧リンクが表示される' do
        users_link = find_all('a')[5].native.inner_text
        expect(users_link).to match('ユーザー一覧')
      end
      it 'アルバム一覧リンクが表示される' do
        albums_link = find_all('a')[6].native.inner_text
        expect(albums_link).to match('アルバム一覧')
      end

      it 'ログアウトリンクが表示される' do
        logout_link = find_all('a')[7].native.inner_text
        expect(logout_link).to match("ログアウト")
      end
    end

    context 'ヘッダーのリンクを確認' do
      subject { current_path }

      it 'ロゴをクリックするとHome画面に遷移する' do
        home_link = find_all('a')[0].native.inner_text
        click_link home_link
        is_expected.to eq(homes_top_path)
      end

      it 'About画面に遷移する' do
        about_link = find_all('a')[1].native.inner_text
        about_link = about_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link about_link
        is_expected.to eq(homes_about_path)
      end
      it 'マイページ画面に遷移する' do
        mypage_link = find_all('a')[2].native.inner_text
        mypage_link = mypage_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link mypage_link
        is_expected.to eq('/users/' + user.id.to_s)
      end

      it 'アルバム作成へ遷移する' do
        album_link = find_all('a')[3].native.inner_text
        album_link = album_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link album_link
        is_expected.to eq('/portraits/new')

      end
      it 'タイムラインへ遷移する' do
        albums_link = find_all('a')[4].native.inner_text
        albums_link = albums_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link albums_link
        is_expected.to eq('/users/' + user.id.to_s + '/timelines')
      end
      it 'ユーザー一覧ページに遷移する' do
        users_link = find_all('a')[5].native.inner_text
        users_link = users_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link users_link
        is_expected.to eq(users_path)
      end
      it 'アルバム一覧に遷移する' do
        albums_link = find_all('a')[6].native.inner_text
        albums_link = albums_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link albums_link
        is_expected.to eq(portraits_path)
      end
      it 'ログアウトする' do
        logout_link = find_all('a')[7].native.inner_text
        logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link logout_link
        is_expected.to eq(root_path)
      end
    end
  end
end
