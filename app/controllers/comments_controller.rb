class CommentsController < ApplicationController
  def create
    session[:previous_url] = request.referer
    @book = Book.find(params[:book_id])
    @user = @book.user
    @comment_new = current_user.comments.new(comment_params)
    @comment_new.book_id = @book.id
    if @comment_new.save
      redirect_to session[:previous_url]
      session.delete(:previous_url)
    else
      @book_new = Book.new 
      render "books/show"
    end
  end

  def destroy
    session[:previous_url] = request.referer
    comment = current_user.comments.find_by(book_id: params[:book_id])
    comment.destroy
    redirect_to session[:previous_url]
    session.delete(:previous_url)
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end
