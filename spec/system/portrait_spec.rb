require 'rails_helper'

describe 'アルバム投稿のテスト' do
  let(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:portrait) { create(:portrait, user: user) }
  let!(:portrait2) { create(:portrait, user: user2) }
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
		    expect(current_path).to eq('/portraits')
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
			it '編集に成功する' do
        fill_in 'portrait[name]', with: 'ねこです'
				click_button '変更を保存'
				# expect(page).to have_content 'successfully'
				expect(current_path).to eq '/portraits/' + portrait.id.to_s
			end
			it '編集に失敗する' do
				fill_in 'portrait[name]', with: ''
				click_button '変更を保存'
				# expect(page).to have_content 'error'
				expect(current_path).to eq '/portraits/' + portrait.id.to_s + '/edit'
			end
		end
	end

  describe '一覧画面のテスト' do
  	before do
  		visit books_path
  	end
  	context '表示の確認' do
  		it 'Booksと表示される' do
  			expect(page).to have_content 'Books'
  		end
  		it '自分と他人の画像のリンク先が正しい' do
  			expect(page).to have_link '', href: user_path(book.user)
  			expect(page).to have_link '', href: user_path(book2.user)
  		end
  		it '自分と他人のタイトルのリンク先が正しい' do
  			expect(page).to have_link book.title, href: book_path(book)
  			expect(page).to have_link book2.title, href: book_path(book2)
  		end
  		it '自分と他人のオピニオンが表示される' do
  			expect(page).to have_content book.body
  			expect(page).to have_content book2.body
  		end
  	end
  end

  describe '詳細画面のテスト' do
  	context '自分・他人共通の投稿詳細画面の表示を確認' do
  		it 'Book detailと表示される' do
  			visit book_path(book)
  			expect(page).to have_content 'Book detail'
  		end
  		it 'ユーザー画像・名前のリンク先が正しい' do
  			visit book_path(book)
  			expect(page).to have_link book.user.name, href: user_path(book.user)
  		end
  		it '投稿のtitleが表示される' do
  			visit book_path(book)
  			expect(page).to have_content book.title
  		end
  		it '投稿のopinionが表示される' do
  			visit book_path(book)
  			expect(page).to have_content book.body
  		end
  	end
  	context '自分の投稿詳細画面の表示を確認' do
  		it '投稿の編集リンクが表示される' do
  			visit book_path book
  			expect(page).to have_link 'Edit', href: edit_book_path(book)
  		end
  		it '投稿の削除リンクが表示される' do
  			visit book_path book
  			expect(page).to have_link 'Destroy', href: book_path(book)
  		end
  	end
  	context '他人の投稿詳細画面の表示を確認' do
  		it '投稿の編集リンクが表示されない' do
  			visit book_path(book2)
  			expect(page).to have_no_link 'Edit', href: edit_book_path(book2)
  		end
  		it '投稿の削除リンクが表示されない' do
  			visit book_path(book2)
  			expect(page).to have_no_link 'Destroy', href: book_path(book2)
  		end
  	end
  end
end