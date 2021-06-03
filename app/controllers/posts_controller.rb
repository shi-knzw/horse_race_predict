class PostsController < ApplicationController

  before_action :authenticate_user
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

  def index
    @posts = Post.all.order(created_at: :desc) #created_atとの間に半角スペースを入れないと正常に動作しなかった。
  end

  def show
    @post = Post.find_by(id:params[:id])
    @user = @post.user
    @likes_count = Like.where(post_id: @post.id).count
  end

  def new
    @post = Post.new
  end
  
  def create

    @post = Post.new(
      content: params[:content],
      user_id: @current_user.id
    )

    if @post.save
      flash[:error] = "ツイートを投稿しました"
      redirect_to("/posts/index")
    else
      render("posts/new")
      flash[:error] = "投稿できる文字数は1字～140字です"
      
    end

  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
  
    if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
      flash[:error] = "投稿できる文字数は1字～140字です"
    end
    
  end

  def destroy

    @post = Post.find_by(id: params[:id])
    @post.destroy

    redirect_to("/posts/index")
    flash[:destro] = "投稿は正常に削除されました"
  end
  
  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end



end