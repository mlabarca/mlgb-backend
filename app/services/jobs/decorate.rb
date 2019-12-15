module Jobs
  # Adds favorites and any other data to json returned by external
  # services.
  class Decorate
    include Service

    def initialize(jobs, email)
      @jobs = jobs
      @email = email
    end

    def execute
      jobs.map do |job|
        job.merge(favorite: favorite_ids.include?(job['id']))
      end
    end

    private

    attr_reader :jobs, :email

    def user_favorites
      @user_favorites ||= Favorite.from_user_email(email)
    end

    # Usage of set makes checking inclusion a O(1) operation.
    def favorite_ids
      @favorite_ids ||= user_favorites.pluck(:job_id).to_set
    end

  end
end
