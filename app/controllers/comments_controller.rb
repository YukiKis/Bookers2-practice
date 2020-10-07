class CommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @user = @book.user
    @comment_new = current_user.comments.new(comment_params)
    @comment_new.book_id = @book.id
    if @comment_new.save
    else
      @book_new = Book.new 
      render "books/show"
    end
    @book.reload
  end

  def destroy
    @book = Book.find(params[:book_id])
    comment = current_user.comments.find_by(book_id: @book.id)
    comment.destroy
    @book.reload
  end

  private
    def comment_params
      params.require(:comment).permit(:content)
    end
end
