module Table
  class HeadersController < Volt::ModelController
    reactive_accessor :search_term
    reactive_accessor :options
    reactive_accessor :values
    before_action :set_default_options

    def set_default_options
      params._per_page ||= 10
    end

    def index
      self.search_term = params._query
    end

    def modal
      self.options = []
      self.values = []
    end

    def toggle_popover
      # message = " <b>' | '</b> - or <br> <b>', '</b> - and <br>"
      # search_fields.each do |field|
      #   message = message + "<b>#{field['field']}:</b> #{field['title']} <br>"
      # end
      # message
      if `$('#popover').css('display') == 'none'`
        `$('#popover').css('display', 'block')`
      else
        `$('#popover').css('display', 'none')`
      end
    end

    def apply_filters
      page._column_filt = []
      puts search_fields
      options.each_with_index do |opt, i|
        unless options[i] == nil || values[i] == nil
          page._column_filt << {col: "#{search_fields[i]['field']}", option: "#{options[i]}", value: "#{values[i]}" }
        end
      end
      `$('#sortModal').modal('hide');`
    end

    def size
      params._per_page.to_i
    end

    def set_table_size(size)
      params._per_page = size
    end

    def search_fields
      search_fields = []
      page._table._columns.each do |col|
        unless col._search_field == nil
          search_fields << {title: col._title, field: col._field_name, search: col._search_field}
        end
      end
      search_fields
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

    def show_sort_modal
      `$('#sortModal').modal('show');`
    end

  end
end
