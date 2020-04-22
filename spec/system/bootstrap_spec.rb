require 'rails_helper'

describe 'boostrapのテスト' do
	let(:user) { create(:user) }
	let!(:portrait) { create(:portrait, user: user) }
	let!(:memory) { create(:memory, portrait: portrait) }
	describe 'グリッドシステムのテスト' do
		before do
			visit new_user_session_path
			fill_in 'user[email]', with: user.email
			fill_in 'user[password]', with: user.password
			click_button 'サインイン'
		end
		context '全体画面' do
			it 'TOP画面' do
				visit homes_top_path
				expect(page).to have_selector('.container')
			end
			it 'about画面' do
				visit homes_about_path
				expect(page).to have_selector('.container')
			end
		end
		context 'ユーザー関連画面' do
			it 'フォロワー画面' do
				visit followers_user_path(user)
				expect(page).to have_selector('.content-box')
			end
			it 'フォロイー画面' do
				visit following_user_path(user)
				expect(page).to have_selector('.content-box')
			end
			it '詳細画面' do
				visit user_path(user)
				expect(page).to have_selector('.content-box')
			end
		end

		# context '検索画面' do
		# 	it '検索結果画面' do
		# 		visit search_path
		# 		expect(page).to have_selector('.content-box')
		# 	end
		# end
		context '投稿関連画面' do
			it '一覧画面' do
				visit portraits_path
				expect(page).to have_selector('.content-box')

			end
			it '詳細画面' do
				visit portrait_path(portrait)
				expect(page).to have_selector('.content-box')

			end
		end
		context '思い出画面' do
			it '詳細画面' do
				visit portrait_memory_path(portrait,memory)
				expect(page).to have_selector('.content-box')
			end
		end
	end
end