require 'rails_helper'

describe 'ページ表示のテスト' do
  let(:user) { create(:user) }
  let!(:portrait) { create(:portrait, user: user) }
  let!(:memory) { create(:memory, portrait: portrait) }
  let!(:anniversary) { create(:anniversary, portrait: portrait, user: user) }

  describe '表示のテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'サインイン'
    end

    context '全体画面' do
      it 'TOP画面' do
        visit homes_top_path
        expect(page).to have_selector('.content-box')
      end
      it 'about画面' do
        visit homes_about_path
        expect(page).to have_selector('.content-box')
      end
    end

    context 'ユーザー関連画面' do
      it 'フォロワー画面' do
        visit followers_user_path(user)
        expect(page).to have_selector('.content-box')
        expect(page).to have_selector('.paginate')
      end
      it 'フォロイー画面' do
        visit following_user_path(user)
        expect(page).to have_selector('.content-box')
        expect(page).to have_selector('.paginate')
      end
      it '一覧画面' do
        visit users_path
        expect(page).to have_selector('.content-box')
        expect(page).to have_selector('.paginate')
      end
      it '詳細画面' do
        visit user_path(user)
        expect(page).to have_selector('.content-box')
        expect(page).to have_selector('.paginate')
      end
      it '編集画面' do
        visit edit_user_path(user)
        expect(page).to have_selector('.content-box')
      end
      it 'タイムライン' do
        visit timelines_user_path(user)
        expect(page).to have_selector('.content-box')
        expect(page).to have_selector('.paginate')
      end
    end

    context '検索画面' do
      it '検索結果画面' do
        visit root_path
        select 'ペット名'
        select '部分一致'
        click_on '検索'

        expect(page).to have_selector('.content-box')
        expect(page).to have_selector('.paginate')
      end
    end

    context 'アルバム関連画面' do
      it '新規投稿' do
        visit new_portrait_path
        expect(page).to have_selector('.content-box')
      end
      it '一覧画面' do
        visit portraits_path
        expect(page).to have_selector('.content-box')
        expect(page).to have_selector('.paginate')
      end
      it '詳細画面' do
        visit portrait_path(portrait)
        expect(page).to have_selector('.content-box')
      end
      it '編集画面' do
        visit edit_portrait_path(portrait)
        expect(page).to have_selector('.content-box')
      end
    end

    context '命日設定関連画面' do
      it '編集画面' do
        visit edit_portrait_anniversary_path(portrait, anniversary)
        expect(page).to have_selector('.content-box')
      end
      it '一覧画面' do
        visit portrait_anniversaries_path(portrait)
        expect(page).to have_selector('.content-box')
      end
    end

    context '思い出画面' do
      it '詳細画面' do
        visit portrait_memory_path(portrait, memory)
        expect(page).to have_selector('.content-box')
      end
      it '編集画面' do
        visit edit_portrait_memory_path(portrait, memory)
        expect(page).to have_selector('.content-box')
      end
    end
  end
end
