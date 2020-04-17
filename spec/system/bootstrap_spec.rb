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
			it '詳細画面' do
				visit homes_about_path
				expect(page).to have_selector('.container')
			end
		end
		context 'ユーザー関連画面' do
			it '一覧画面' do
				visit users_path
				expect(page).to have_selector('.container')
			end
			it '詳細画面' do
				visit user_path(user)
				expect(page).to have_selector('.container .row')

			end
		end
		context '投稿関連画面' do
			it '一覧画面' do
				visit portraits_path
				expect(page).to have_selector('.container .row')

			end
			it '詳細画面' do
				visit portrait_path(portrait)
				expect(page).to have_selector('.container .row')

			end
		end
		context '思い出画面' do
			it '詳細画面' do
				visit portrait_memory_path(portrait,memory)
				expect(page).to have_selector('.container .row')
			end
		end
	end
end