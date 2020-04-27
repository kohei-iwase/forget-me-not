require 'rails_helper'

describe '供養日設定のテスト' do
  let(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:portrait) { create(:portrait, user: user) }
  let!(:portrait2) { create(:portrait, user: user2) }
  let!(:memory) { create(:memory, portrait: portrait) }
  let!(:memory2) { create(:memory, portrait: portrait2) }
  let!(:anniversary) { create(:anniversary, user: user,portrait: portrait) }
  let!(:anniversary2) { create(:anniversary, user: user2,portrait: portrait2) }
  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'サインイン'
  end
  describe '供養日設定画面のテスト' do
  	context '供養日設定画面の表示を確認' do
      before do
        visit edit_portrait_anniversary_path(portrait,anniversary)
      end
      it 'titleフォームが表示される' do
        expect(page).to have_field 'anniversary[title]'
      end
      it 'memoフォームが表示される' do
        expect(page).to have_field 'anniversary[memo]'
      end
      it 'dateフォームが表示される' do
        expect(page).to have_field 'anniversary[date]'
      end
      it '供養日の設定ボタンが表示される' do
        expect(page).to have_button '供養日の設定'
      end
      it 'アルバムに戻るボタンが表示される' do
        expect(page).to have_content 'アルバムに戻る'
      end
      it '供養日一覧ボタンが表示される' do
        expect(page).to have_content '供養日一覧'
      end
    end
    context '設定画面の機能を確認' do
      before do
        visit edit_portrait_anniversary_path(portrait,anniversary)
      end
      it '供養日設定に成功する' do
        fill_in 'anniversary[title]', with: '懐かしい'
        fill_in 'anniversary[memo]', with: Faker::Lorem.characters(number:20)
        fill_in 'anniversary[date]', with: '20202020'
        click_button '供養日の設定'
        expect(page).to have_content '供養日一覧'
      end
      it '供養日設定に失敗する' do
        fill_in 'anniversary[title]', with: ''
        fill_in 'anniversary[memo]', with: ''
        fill_in 'anniversary[date]', with: ''
        click_button '供養日の設定'
        # expect(page).to have_content 'error'
        expect(page).to have_content '供養日の設定'
      end
      it 'アルバムに戻るボタンをクリック' do
        click_on "アルバムに戻る"
        expect(current_path).to eq portrait_path(portrait)
      end
      it '供養日一覧ボタンをクリック' do
        click_on "供養日一覧"
        expect(current_path).to eq portrait_anniversaries_path(portrait)
      end
    end
  end
  describe '供養日一覧画面のテスト' do
    context '自分の供養日一覧画面の表示確認' do
      before do
        visit portrait_anniversaries_path(portrait)
      end
      it 'titleが表示される' do
        expect(page).to have_content anniversary.title
      end
      it 'memoフォームが表示される' do
        expect(page).to have_content anniversary.memo
      end
      it 'dateフォームが表示される' do
        expect(page).to have_content anniversary.date
      end
      it '編集ボタンが表示される' do
        expect(page).to have_content '編集'
      end
      it '削除ボタンが表示される' do
        expect(page).to have_content '削除'
      end
      it '他人の供養日が表示されない' do
        expect(page).to have_no_content anniversary2.title
      end
    end

    context '自分の供養日一覧の機能確認' do
      before do
        visit portrait_anniversaries_path(portrait)
      end
      it '編集ボタンをクリック' do
        click_on "編集"
        expect(current_path).to eq edit_portrait_anniversary_path(portrait,anniversary)
      end
      it '削除ボタンをクリック' do
        click_on "削除"
        expect(current_path).to eq portrait_anniversaries_path(portrait)
      end
    end
  end
end