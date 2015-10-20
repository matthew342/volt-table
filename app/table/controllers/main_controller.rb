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
      puts "triggering #{event}"
      trigger(event, item_id, col_index)
    end

    def start_offset
      (((params._page || 1).to_i - 1) * params._per_page.to_i)
    end

    def searched_data
      query = { '$regex' => params._query || '', '$options' => 'i' }
      search_hsh = []
      page._table._search_fields.each do |field|
        search_hsh << {field => query}
      end
      base = attrs.source
      unless search_hsh.empty?
        base = base.where({'$or' => search_hsh})
      end
      base
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
