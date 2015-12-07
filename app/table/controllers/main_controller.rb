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
      end
      attrs.source.where(query)
    end

    def build_query
      ands = []
      # split at commas to get my array of queries (commas are AND)
      and_pieces = params._query.split(', ')
      and_pieces.each do |and_piece|
        ands << recursive_query_parse(and_piece)
      end
      search_query = {'$and' => ands}
      puts search_query
      search_query
    end

    def recursive_query_parse(query)
      inner_query = []
      or_pieces = query.split(' | ')
      or_pieces.each do |query|
        # split the query to get an 'or' pieces (separated by a pipe)
        if query.is_a?(Array)
          inner_query.push(recursive_query_parse(query)).flatten!
        else
          inner_query.push(name_match(query)).flatten!
          inner_query.push(other_match(query)).flatten!
        end
      end
      {'$or' => inner_query}
    end

    def name_match(query)
      name_queries = []
      name_matchset = query.match(/(\w*)\s?(\w*)?/)
      last_name_query = name_matchset[2] || name_matchset[1]
      if name_matchset
        if page._table._search_fields.include?('first_name')
          name_queries << {:first_name => { '$regex' => name_matchset[1] || '', '$options' => 'i' }}
        end
        if page._table._search_fields.include?('last_name')
          name_queries << {:last_name => { '$regex' => last_name_query || '', '$options' => 'i' }}
        end
      end
      if name_queries.length > 1 && name_matchset[2]
        {'$and' => name_queries}
      else
        name_queries
      end
    end

    def other_match(query)
      other_queries = []
      clean_string = query.gsub(/(\w*)\s(\w*)/, '')
      unless clean_string.empty?
        page._table._search_fields.reject { |field_name| field_name.include?('first_name') || field_name.include?('last_name')}.each do |field|
          other_queries << {field => { '$regex' => clean_string, '$options' => 'i' }}
        end
      end
      other_queries
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
      #searched_data.count
      500
    end

  end
end
