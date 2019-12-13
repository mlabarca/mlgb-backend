# Api for querying the jobs endpoint, must return jobs
# marked as favorite for given cookie.
class JobsController < ApplicationController
  def search
    render json: { jobs: [] }, status: :ok
  end
end
