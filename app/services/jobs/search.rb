module Jobs
  # Calls the GetOnBoard service and adds some logic like cache,
  # Favorites, etc.
  class Search
    include Service
    CACHE_HOURS = 1

    def initialize(params)
      @params = params
    end

    def execute
      {
        jobs:         decorated_results,
        total_docs:   decorated_results.count
      }
    end

    private

    attr_reader :params

    def job_results
      Rails.cache.fetch(cache_key, expires_in: CACHE_HOURS.hours) do
        GetOnBoard::FetchJobs.execute(query)
      end
    end

    def decorated_results
      @decorated_results ||= Jobs::Decorate.execute(job_results, email)
    end

    def query
      params[:q] || ''
    end

    def email
      params[:email]
    end

    def cache_key
      query + '_cache'
    end
  end
end
