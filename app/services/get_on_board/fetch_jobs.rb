module GetOnBoard
  # Makes the http request to Get On Board api for jobs
  class FetchJobs
    include Service

    def initialize(query)
      @query = query || ''
    end

    def execute

      response['jobs'] || []
    rescue StandardError => error
      Rails.logger.warn "Error calling GetOnBoard Service: #{error}"
      []
    end

    private

    attr_reader :query

    def response
      @response ||= JSON.parse(Typhoeus.get(prepared_url).body)
    end

    def prepared_url
      Rails.configuration.services.gb_endpoint + query
    end
  end
end
