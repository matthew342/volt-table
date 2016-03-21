module Table
  class MainController < Volt::ModelController
    before_action :set_default_options, only: :index

    def set_default_options
      params._per_page ||= 10
      params._sort_direction ||= 1
    end

    def trigger_row_click(item_id)
      # event = page._table._default_e_click
      # event ||=
      # trigger('row_click', item_id)
    end

    def td_click(item_id, col_index)
      event = page._table._columns[col_index]._click_event
      event ||= page._table._default_click_event
      trigger(event, item_id, col_index)
    end

    def start_offset
      (((params._page || 1).to_i - 1) * params._per_page.to_i)
    end

    def searched_data
      if params._query && !params._query.empty?
        query = build_query
      else
        query = column_filters
      end
      attrs.source.where(query)
    end

    def build_query
      if params._query
        ands = []
        # split at commas to get my array of queries (commas are AND)
        and_pieces = params._query.split(',').map(&:strip)
        and_pieces.each_with_index do |piece, i|
          if piece =~ /\|/
            or_query = []
            or_pieces = piece.split('|').map(&:strip)
            or_pieces.each_with_index do |p, i|
              if /:/.match(p)
                or_query.push(field_match(p)).flatten!
              else
                or_query.push(any_match(p)).flatten!
              end
            end
            ands << {'$or' => or_query}
          elsif /:/.match(piece) # if part of the query is a specific field search
            ands << field_match(piece)
          else
            ands << {'$or' => any_match(piece)}
          end
        end
        ands << column_filters
        {'$and' => ands}
      end
    end

    def field_match(query)
      clean_string = query.split(':').map(&:strip)
      if search_fields.has_key?(clean_string[0])
        {search_fields[clean_string[0]] => {"$regex"=>clean_string[1], "$options"=>"i"}}
      else
        {}
      end
    end

    def any_match(query)
      match = []
      search_fields.values.each do |field|
        match << {field => { '$regex' => "#{query}", '$options' => 'i' }}
      end
      match
    end

    def column_filters
      ands = []
      if page._column_filt == nil || page._column_filt == []
        {}
      else
        page._column_filt.each do |filter|
          ands << {filter._col => {"#{filter._option}" => "#{filter._value}"}}
        end
        {'$and' => ands}
      end
    end

    def search_fields
      fields = {}
      page._table._columns.each do |col|
        unless col._search_field == nil
          fields[col._search_field] = col._field_name
        end
      end
      fields
    end

    def ordered_data
      if params._sort_direction
        searched_data.order(params._sort_field => params._sort_direction.to_i)
      else
        searched_data
      end
    end

    def current_page
      per_page = params._per_page.to_i
      per_page = 10 unless per_page > 0
      ordered_data.skip(start_offset).limit(per_page)
    end

    def total_size
      # TODO: volt-mongo loads the entire collection into memory for counts as of 9-7-15
      attrs.total_size || 500 #attrs.source.count
    end

    def table_size
      # TODO: volt-mongo loads the entire collection into memory for counts as of 9-7-15
      # searched_data.count
      attrs.total_size || 500
    end

  end
end
