require 'rails_helper'

describe 'ユーザー認証のテスト' do
  describe 'ユーザー新規登録' do
    before do
      visit new_user_registration_path
    end
    context '新規登録画面に遷移' do
      it '新規登録に成功する' do
        fill_in 'user[name]', with: "TEST"
        fill_in 'user[email]', with: Faker::Internet.email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_button '新規登録'

        expect(current_path).to eq(root_path)
      end
      it '新規登録に失敗する' do
        fill_in 'user[name]', with: ''
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        fill_in 'user[password_confirmation]', with: ''
        click_button '新規登録'

        expect(page).to have_content 'errors'
      end
    end
  end
  describe 'ユーザーログイン' do
    let(:test_user) { create(:user) }
    before do
      visit new_user_session_path
    end
    context 'ログイン画面に遷移' do
      it 'ログインに成功する' do
        fill_in 'user[email]', with: test_user.email
        fill_in 'user[password]', with: test_user.password
        click_button 'サインイン'

        expect(current_path).to eq(root_path)
      end

      it 'ログインに失敗する' do
        fill_in 'user[email]', with: ''
        fill_in 'user[password]', with: ''
        click_button 'サインイン'

        expect(current_path).to eq(new_user_session_path)
      end
    end
  end
end

describe 'ユーザーのテスト' do
  let(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:portrait) { create(:portrait, user: user) }
  let!(:memory) { create(:memory, portrait: portrait) }
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'サインイン'
  end
  describe '表示のテスト' do
    context 'マイページのテスト' do
      before do
        visit user_path(user)
      end
      it '遷移できる' do
        expect(current_path).to eq('/users/' + user.id.to_s)
      end
      it '画像が表示される' do
        expect(page).to have_css('img.image')
      end
      it '名前が表示される' do
        expect(page).to have_content(user.name)
      end
      it '自己紹介が表示される' do
        expect(page).to have_content(user.introduction)
      end
      it '編集リンクが表示される' do
        expect(page).to have_link '', href: edit_user_path(user)
      end
    end
  end

  describe 'プロフィール編集のテスト' do
    context '自分の編集画面への遷移' do
      it '遷移できる' do
        visit edit_user_path(user)
        expect(current_path).to eq('/users/' + user.id.to_s + '/edit')
      end
    end
    context '他人の編集画面への遷移' do
      it '遷移できない' do
        visit edit_user_path(user2)
        expect(current_path).to eq('/users/' + user.id.to_s)
      end
    end

    context '編集画面の表示の確認' do
      before do
        visit edit_user_path(user)
      end
      it 'タイトルが表示されている' do
        expect(page).to have_content('プロフィール編集')
      end
      it '名前編集フォームに自分の名前が表示される' do
        expect(page).to have_field 'user[name]', with: user.name
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field 'user[image]'
      end
      it '自己紹介編集フォームに自分の自己紹介が表示される' do
        expect(page).to have_field 'user[introduction]', with: user.introduction
      end
      it '自己紹介編集フォームに自分の自己紹介が表示される' do
        expect(page).to have_button '変更を保存'
      end
      it '編集に成功する' do
        fill_in 'user[name]', "hoge"
        click_button '変更を保存'
#        expect(page).to have_content 'successfully'
        expect(current_path).to eq('/users/' + user.id.to_s)
      end
      it '編集に失敗する' do
        fill_in 'user[name]', with: ''
        click_button '変更を保存'
#        expect(page).to have_content 'error'
				#もう少し詳細にエラー文出したい
        expect(current_path).to eq('/users/' + user.id.to_s + '/edit')
      end
    end
  end

  describe '一覧画面のテスト' do
    before do
      visit users_path
    end
    context '表示の確認' do
      it '自分と他の人の画像が表示される' do
        expect(all('img').size).to eq(2)
      end
      it '自分と他の人の名前が表示される' do
        expect(page).to have_content user.name
        expect(page).to have_content user2.name
      end
      it 'ユーザーへのリンクが表示される' do
        expect(page).to have_link user.name, href: user_path(user)
        expect(page).to have_link user2.name, href: user_path(user2)
      end
    end
  end
  describe '詳細画面のテスト' do
    before do
      visit user_path(user)
    end
    context '表示の確認' do
      it 'アルバムの表記がある' do
        expect(page).to have_content('アルバム')
      end
      it '投稿一覧のユーザーの画像のリンク先が正しい' do
        expect(page).to have_link '', href: user_path(user)
      end
      it 'アルバムのリンク先が正しい' do
        expect(page).to have_link portrait.name, href: portrait_path(portrait)
      end
      it '投稿一覧にmore_about_meが表示される' do
        expect(page).to have_content(portrait.more_about_me)
      end
    end
  end
end
