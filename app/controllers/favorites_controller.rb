class FavoritesController < ApplicationController
  def create
    session[:previous_url] = request.referer
    book = Book.find(params[:book_id])
    if !(book.favorited_by?(current_user))
      favorite = current_user.favorites.new
      favorite.book_id = book.id
        if favorite.save
          redirect_to session[:previous_url]
          session.delete(:previous_url)
        end
    end
  end

  def destroy
    session[:previous_url] = request.referer
    book = Book.find(params[:book_id])
    if favorite = Favorite.find_by(user_id: current_user.id, book_id: book.id)
      favorite.destroy
      redirect_to session[:previous_url]
      session.delete(:previous_url)
    end
  end
end
