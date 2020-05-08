require 'rails_helper'

describe '思い出投稿のテスト' do
  let(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:portrait) { create(:portrait, user: user) }
  let!(:portrait2) { create(:portrait, user: user2) }
  let!(:memory) { create(:memory, portrait: portrait) }
  let!(:memory2) { create(:memory, portrait: portrait2) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'サインイン'
  end

  describe '思い出詳細画面のテスト' do
    context '自分の思い出詳細画面の表示を確認' do
      before do
        visit portrait_memory_path(portrait, memory)
      end

      it 'タイトルが表示される' do
        expect(page).to have_content memory.title
      end
      it '画像が表示される' do
        expect(all('img').size).to eq(4)
      end
      it '投稿の編集リンクが表示される' do
        expect(page).to have_link '思い出に書き加える', href: edit_portrait_memory_path(portrait, memory)
      end
      it '削除のリンクが表示される' do
        expect(page).to have_link 'この思い出と別れる', href: portrait_memory_path(portrait, memory)
      end
      it 'アルバムに戻るが表示されている' do
        expect(page).to have_link 'アルバムに戻る', href: portrait_path(portrait)
      end
      it '他人のアルバムの思い出が表示されない' do
        expect(page).to have_no_link memory2.title, href: portrait_memory_path(portrait2, memory2)
      end
      it '献花ボタンが表示されない' do
        expect(page).to have_no_button '献花する'
      end
    end

    context '自分の思い出詳細画面の機能を確認' do
      before do
        visit portrait_memory_path(portrait, memory)
      end

      it '思い出編集画面に遷移する' do
        click_on '思い出に書き加える'
        expect(current_path).to eq('/portraits/' + portrait.id.to_s + '/memories/' + memory.id.to_s + '/edit')
      end
      it '思い出を削除する' do
        click_on 'この思い出と別れる'
        # expect.to change(portrait.memory.count).by(-1)
        expect(current_path).to eq('/portraits/' + portrait.id.to_s)
        expect(page).to have_content '削除しました'
      end
      it 'アルバムに戻るする' do
        click_on 'アルバムに戻る'
        expect(current_path).to eq('/portraits/' + portrait.id.to_s)
      end
    end

    context '他人の思い出詳細画面の表示を確認' do
      before do
        visit portrait_memory_path(portrait2, memory2)
      end

      it 'タイトルが表示される' do
        expect(page).to have_content memory2.title
      end
      it '画像が表示される' do
        expect(all('img').size).to eq(4)
      end
      # it '献花ボタンが表示される' do
      #   expect(page).to have_button '献花する'
      # end

      it '投稿の編集リンクが表示されない' do
        expect(page).to have_no_button '思い出に書き加える'
      end
      it '削除のリンクが表示されない' do
        expect(page).to have_no_button 'この思い出と別れる'
      end
      it 'アルバムに戻るが表示されている' do
        expect(page).to have_link 'アルバムに戻る', href: portrait_path(portrait2)
      end
    end
  end

  describe '思い出編集画面のテスト' do
    context '自分の編集画面の表示を確認' do
      before do
        visit edit_portrait_memory_path(portrait, memory)
      end

      it 'titleフォームが表示される' do
        expect(page).to have_field 'memory[title]'
      end
      it 'whenフォームが表示される' do
        expect(page).to have_field 'memory[when]'
      end
      it 'memoryフォームが表示される' do
        expect(page).to have_field 'memory[memory]'
      end
      it '思い出を作るボタンが表示される' do
        expect(page).to have_button '思い出を更新！'
      end
    end

    context '自分の編集画面の機能を確認' do
      before do
        visit edit_portrait_memory_path(portrait, memory)
      end

      it '思い出編集に成功する' do
        fill_in 'memory[title]', with: '懐かしい'
        fill_in 'memory[when]', with: Faker::Lorem.characters(number: 5)
        fill_in 'memory[memory]', with: Faker::Lorem.characters(number: 20)
        click_button '思い出を更新！'
        expect(page).to have_content '成功しました'
        expect(page).to have_content '懐かしい'
        expect(current_path).to eq('/portraits/' + portrait.id.to_s + '/memories/' + memory.id.to_s)
      end
      it '思い出編集に失敗する' do
        fill_in 'memory[title]', with: ''
        fill_in 'memory[memory]', with: '表示されない'
        click_button '思い出を更新！'
        expect(page).to have_content '失敗しました'
        expect(page).to have_no_content '表示されない'
        expect(current_path).to eq('/portraits/' + portrait.id.to_s + '/memories/' + memory.id.to_s + '/edit')
      end
    end
  end
end
