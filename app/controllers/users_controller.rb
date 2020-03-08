class UsersController < ApplicationController
	 before_action :authenticate_user!
   before_action :ensure_correct_user, {only: [:edit, :update]}

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
    @book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）

  end

  def index
  	@users = User.all #一覧表示するためにUserモデルのデータを全て変数に入れて取り出す。
  	@book = Book.new #new bookの新規投稿で必要（保存処理はbookコントローラー側で実施）
    @user = current_user
  end
  def edit
   @user = User.find(params[:id])
 end

 def update
   @user = User.find(params[:id])
   @user_id = current_user.id
   if @user.update(user_params)
    redirect_to user_path(@user.id), notice: "successfully updated user!"
  else
    render "edit"
  end
end

private
def user_params
  params.require(:user).permit(:name, :introduction, :profile_image,:postcode, :prefecture_code, :address_city, :address_street,:latitude,:longitude)
end

  #url直接防止　メソッドを自己定義してbefore_actionで発動。
  def baria_user
  	unless params[:id].to_i == current_user.id
  		redirect_to user_path(current_user)
    end
  end
  def book_params
  params.require(:book).permit(:title, :body)
end
def ensure_correct_user
  @user = User.find(params[:id])
  if current_user.id != params[:id].to_i
    flash[:notice] = "権限がありません"
    redirect_to ('/users/sign_in')
  end
end
end

