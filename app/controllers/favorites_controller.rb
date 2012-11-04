class FavoritesController < ApplicationController

  def create
    @user = current_user
    @favorite = Favorite.new_from_url(params[:url])
    if current_user.add_favorite(@favorite)
      respond_to do |format|
        format.html { render(layout: false) }
        format.json { render(json: @favorite) }
      end
    else
      render(@favorite.errors, status: :unprocessable_entity)
    end
  end

  def update
    current_user.favorites.find(params[:id]).reorder(params[:position].to_i)
    render(text: 'OK')
  end

  def destroy
    current_user.favorites.find(params[:id]).destroy
    head(:no_content)
  end

end
