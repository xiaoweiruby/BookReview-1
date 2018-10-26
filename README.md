# 构建一个新的专案
```
rails new BookReview
cd BookReview
git init
git add .
git commit -m "initial commit"
git remote add origin https://github.com/xiaoweiruby/BookReview-1.git
git push -u origin master
```
# 穿上衣服 bootstrap & simple form
git checkout -b bootstrap
Gemfile
```
gem 'simple_form', '~> 4.0', '>= 4.0.1'
gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
```

bundle install
rails generate simple_form:install --bootstrap



# 增加 Book 的 CRUD
```
git checkout -b books
rails g model Book title:string description:text author:string
rake db:migrate
rails g controller Books
```
class BooksController < ApplicationController
	before_action :find_book, only: [:show, :edit, :update, :destroy]


	def index
		@books = Book.all.order("created_at DESC")
	end

	def show

	end

	def new
		@book = Book.new

	end

	def create
		@book = Book.new(book_params)


		if @book.save
			redirect_to root_path
		else
			render 'new'
		end
	end

	def edit

	end

	def update
		if @book.update(book_params)
			redirect_to book_path(@book)
		else
			render 'edit'
		end
	end

	def destroy
		@book.destroy
		redirect_to root_path
	end

	private

		def book_params
			params.require(:book).permit(:title, :description, :author)
		end

		def find_book
			@book = Book.find(params[:id])
		end

end

```
touch app/views/books/_form.html.erb
```
<%= simple_form_for @book, :html => { :multipart => true } do |f| %>

	<%= f.input :title, label: "Book Title" %>
	<%= f.input :description %>
	<%= f.input :author %>
	<%= f.button :submit, :class => 'btn-custom2' %>
<% end %>

```
touch app/views/books/index.html.erb
```

		<% @books.each do |book| %>

			  <h2><%= link_to book.title, book_path(book) %></h2>


		<% end %>

<%= link_to "Add Book", new_book_path %>

```
touch app/views/books/new.html.erb
```
<div class="col-md-6 col-md-offset-3">

	<div class="new-book-form">

		<h1>New Book</h1>

		<%= render 'form' %>

	</div>

</div>
```
touch app/views/books/edit.html.erb
```
<div class="col-md-6 col-md-offset-3">

	<div class="edit-book-form">

		<h1>Edit Book</h1>

		<%= simple_form_for @book, :html => { :multipart => true } do |f| %>

			<%= f.input :title, label: "Book Title" %>
			<%= f.input :description %>
			<%= f.input :author %>
			<%= f.button :submit, :class => "btn-custom2" %>
		<% end %>

	</div>

</div>

```
touch app/views/books/show.html.erb

```


			<h2 class="book-title"><%= @book.title %></h2>
			<h3 class="book-author"><span>From</span> <%= @book.author %></h3>

			<p class="book-desc"><%= @book.description %></p>





<div class="links btn-group">

	<%= link_to "Back", root_path, class: "btn btn-custom" %>

			<%= link_to "Edit", edit_book_path(@book), class: "btn btn-custom" %>
			<%= link_to "Delete", book_path(@book), method: :delete, data: { confirm: "Are you sure?" }, class: "btn btn-custom" %>


</div>

```
