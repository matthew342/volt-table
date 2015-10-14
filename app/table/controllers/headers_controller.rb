module Table
  class HeadersController < Volt::ModelController
    reactive_accessor :search_term
    before_action :set_default_options

    def set_default_options
      params._per_page ||= 10
    end

    def index
      self.search_term = params._query
    end

    def size
      params._per_page.to_i
    end

    def set_table_size(size)
      params._per_page = size
    end

    def search
      unless @last_hit.nil? || search_term.length == 1
        if (Time.now - @last_hit) >= 0.5
          params._query = search_term
        else
          timeout unless @timeout
        end
      end
      @last_hit = Time.now
    end

    def timeout
      unless @timeout
        @timeout = true
        `setTimeout(function(){#{timeout_search}}, 500)`
      end
    end

    def timeout_search
      @timeout = false
      search
    end

  end
end
