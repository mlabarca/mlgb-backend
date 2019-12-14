# Api for querying the jobs endpoint, must return jobs
# marked as favorite for given cookie.
class JobsController < ApplicationController
  def search
    render json: Jobs::Search.execute(allowed_params), status: :ok
  end

  private

  def allowed_params
    params.permit(:q, :email).to_h
  end
end
