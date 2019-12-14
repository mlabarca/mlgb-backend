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
        jobs:         job_results,
        total_docs:   job_results.count
      }
    end

    private

    attr_reader :params

    def job_results
      @job_results ||= begin
        Rails.cache.fetch(cache_key, expires_in: CACHE_HOURS.hours) do
          GetOnBoard::FetchJobs.execute(query)
        end
      end
    end

    def query
      params[:q]
    end

    def cache_key
      query + '_cache'
    end
  end
end
