class FavoritesController < ApplicationController
  def create
    favorite = Favorite.create(allowed_params)

    if favorite.save
      render json: {id: favorite.id}, status: :ok
    else
      errors = favorite.errors.full_messages.join(',')
      render json: {errors: errors}, status: :unprocessable_entity
    end
  end

  def delete
    favorite = Favorite.find_by(allowed_params)

    if favorite
      favorite.destroy
      render json: {}, status: :ok
    else

      render json: {}, status: :not_found
    end
  end

  private

  def allowed_params
    params.permit(:job_id, :email).to_h
  end
end
