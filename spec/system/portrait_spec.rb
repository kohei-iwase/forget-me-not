require 'rails_helper'

describe 'アルバム投稿のテスト' do
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
  describe '投稿のテスト' do
		context 'アルバム作成' do
      before do
        visit new_portrait_path
      end

      it '投稿ページへ遷移できる' do
        expect(current_path).to eq('/portraits/new')
      end
		  it '「アルバム作成」と表示される' do
	    	expect(page).to have_content 'アルバム作成'
		  end
		  it 'titleフォームが表示される' do
		  	expect(page).to have_field 'portrait[name]'
		  end
		  it 'more_about_meフォームが表示される' do
		  	expect(page).to have_field 'portrait[more_about_me]'
		  end
		  it 'アルバム作成ボタンが表示される' do
		  	expect(page).to have_button 'アルバムを作成'
		  end
		  it 'アルバム作成に成功する' do
		  	fill_in 'portrait[name]', with: Faker::Lorem.characters(number:5)
		  	fill_in 'portrait[more_about_me]', with: Faker::Lorem.characters(number:20)
		  	click_button 'アルバムを作成'
		  	expect(page).to have_content 'について'
        expect(current_path).to eq('/portraits/3/edit')
		  end
		  it 'アルバム作成に失敗する' do
		  	click_button 'アルバムを作成'
		  	# expect(page).to have_content 'error'
		  	expect(current_path).to eq('/portraits/new')
		  end
		end
  end

  describe '編集のテスト' do
  	context '自分の投稿の編集画面への遷移' do
  	  it '遷移できる' do
	  		visit edit_portrait_path(portrait)
	  		expect(current_path).to eq('/portraits/' + portrait.id.to_s + '/edit')
	  	end
	  end
		context '他人の投稿の編集画面への遷移' do
		  it '遷移できない' do
		    visit edit_portrait_path(portrait2)
		    expect(current_path).to eq('/portraits/' + portrait2.id.to_s)
		  end
		end
		context '表示の確認' do
			before do
				visit edit_portrait_path(portrait)
			end
			it 'アルバムのタイトルが表示される' do
				expect(page).to have_content(portrait.name)
			end
			it 'name編集フォームが表示される' do
				expect(page).to have_field 'portrait[name]', with: portrait.name
			end
			it 'more_about_me編集フォームが表示される' do
				expect(page).to have_field 'portrait[more_about_me]', with: portrait.more_about_me
			end
			it '削除ボタンが表示される' do
				expect(page).to have_link '削除', href: portrait_path(portrait)
			end
			it 'アルバムに戻るリンクが表示される' do
				expect(page).to have_link 'アルバムに戻る', href: portrait_path(portrait)
			end
		end
		context 'フォームの確認' do
      before do
        visit edit_portrait_path(portrait)
      end
			# it '編集に成功する' do
   #      fill_in 'portrait[name]', with: "hoge"
			# 	click_button '変更を保存'
			# 	# expect(page).to have_content 'successfully'
   #      expect(page).to have_content "hoge"
			# end
			it '編集に失敗する' do
				fill_in 'portrait[name]', with: ''
				click_button '変更を保存'
				# expect(page).to have_content 'error'
				expect(current_path).to eq '/portraits/' + portrait.id.to_s + '/edit'
			end
		end
	end

  describe 'タイムラインのテスト' do
  	before do
  		visit portraits_path
  	end
  	context '表示の確認' do
  		it 'タイムラインと表示される' do
  			expect(page).to have_content 'タイムライン'
  		end
  		# it '自分と他人の画像のリンク先が正しい' do
  		# 	expect(page).to have_link '', href: user_path(portrait.user)
  		# 	expect(page).to have_link '', href: user_path(portrait2.user)
  		# end
  		it '自分と他人のタイトルのリンク先が正しい' do
  			expect(page).to have_link portrait.name, href: portrait_path(portrait)
  			expect(page).to have_link portrait2.name, href: portrait_path(portrait2)
  		end
  		it '自分と他人のアルバム概要が表示される' do
  			expect(page).to have_content portrait.more_about_me
  			expect(page).to have_content portrait2.more_about_me
  		end
  	end
  end

  describe 'アルバム画面のテスト' do
  	context '自分・他人共通の投稿詳細画面の表示を確認' do
      before do
        visit portrait_path(portrait)
      end
  		it 'アルバム名が正しく表示される' do
  			expect(page).to have_content(portrait.name)
  		end
  		 it 'ユーザー1の画像・名前のリンク先が正しい' do
  		 	expect(page).to have_link portrait.user.name, href: user_path(portrait.user)
       end
    		it 'アルバムのmore_about_meが表示される' do
  			expect(page).to have_content portrait.more_about_me
  		end
  	end
  	context '自分のアルバム詳細画面の表示を確認' do
      before do
        visit portrait_path portrait
      end
  		it 'アルバムの編集リンクが表示される' do
  			expect(page).to have_link '編集', href: edit_portrait_path(portrait)
  		end
  		it '献花のリンクが表示されない' do
  		  	expect(page).to have_no_link '献花する', href: portrait_bouquets_path(portrait)
  		end
      it 'アルバムの思い出が表示される' do
        expect(page).to have_link memory.title, href: portrait_memory_path(portrait,memory)
      end
      it '他人のアルバムの思い出が表示されない' do
        expect(page).to have_no_link memory2.title, href: portrait_memory_path(portrait2,memory2)
      end
    end
    context '思い出投稿機能の確認' do
      before do
        visit portrait_path portrait
      end
      it '「思い出を加える」と表示される' do
        expect(page).to have_content '思い出を加える'
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
        expect(page).to have_button '思い出を作る！'
      end
      it '思い出作成に成功する' do
        fill_in 'memory[title]', with: '懐かしい'
        fill_in 'memory[when]', with: Faker::Lorem.characters(number:5)
        fill_in 'memory[memory]', with: Faker::Lorem.characters(number:20)
        click_button '思い出を作る！'
        expect(page).to have_content '懐かしい'
        expect(current_path).to eq('/portraits/' + portrait.id.to_s + '/memories/3' )
      end
      it '思い出作成に失敗する' do
        fill_in 'memory[memory]', with: Faker::Lorem.characters(number:20)
        click_button '思い出を作る！'
        # expect(page).to have_content 'error'
        expect(page).to have_no_content '懐かしい'
        expect(current_path).to eq('/portraits/' + portrait.id.to_s)
      end
    end

  	context '他人のアルバム詳細画面の表示を確認' do
  		it 'アルバムの編集リンクが表示されない' do
  			visit portrait_path(portrait2)
  			expect(page).to have_no_link '編集', href: edit_portrait_path(portrait2)
  		end
      # it '献花のリンクが表示される' do
      #   visit portrait_path portrait(portrait2) 
      #   expect(page).to have_link '献花する', href: portrait_bouquets_path(portrait2)
      # end
      it '思い出投稿フォームが表示されない' do
        expect(page).to have_no_content '思い出を加える'
      end
  	end
  end
end