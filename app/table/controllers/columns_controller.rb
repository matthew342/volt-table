module Table
  class ColumnsController < Volt::ModelController
    reactive_accessor :options
    reactive_accessor :values

    ##############
    # Actions
    ##############

    def index
      page._column_filt = []
    end

    ##############
    # Callbacks
    ##############

    ##############
    # Data Sources
    ##############

    ##############
    # Events
    ##############
    def sort(field)
      if field
        toggle_sort_direction(field)
        params._sort_field = field
      end
    end

    def toggle_sort_direction(field)
      if params._sort_field == field
        if params._sort_direction.to_i == 1
          params._sort_direction = -1
        else
          params._sort_direction = 1
        end
      end
    end

    def apply_filters(item, event)
      page._column_filt << {col: "#{item}", option: "#{options}", value: "#{values}" }
      page._column_filt = page._column_filt.reject { |h| item.to_s.include? h._col }
      unless options == nil || values == nil || options == '' || values == ''
        page._column_filt << {col: "#{item}", option: "#{options}", value: "#{values}" }
      end
      `$(#{event.target}).closest('.dropdown').removeClass('open')`
      nil
    end

    def reset(item, event)
      options = ""
      values = ""
      if page._column_filt.any? { |x| x._col == item.to_s }
        page._column_filt = page._column_filt.reject { |h| item.to_s.include? h._col }
      end
      `$(#{event.target}).closest('.dropdown').removeClass('open')`
      nil
    end

    ##############
    # Display
    ##############
    def header_sort_klass(label)
      if params._sort_field == label
        params._sort_direction.to_i == 1 ? 'headerSortDown' : 'headerSortUp'
      end
    end

    def sort_direction(reverse)
      if reverse
        params._sort_direction.to_i == 1 ? 'down' : 'up'
      else
        params._sort_direction.to_i == 1 ? 'up' : 'down'
      end
    end

    def filter_label(filter)
      if page._column_filt.any? { |x| x._col == filter.to_s }
        index = page._column_filt.index {|x| x._col == filter.to_s }
        if page._column_filt[index]._option.to_s == '$ne'
          "!= #{page._column_filt[index]._value}"
        elsif page._column_filt[index]._option == '$gt'
          "> #{page._column_filt[index]._value}"
        elsif page._column_filt[index]._option == '$lt'
          "< #{page._column_filt[index]._value}"
        elsif page._column_filt[index]._option == '$lte'
          "<= #{page._column_filt[index]._value}"
        elsif page._column_filt[index]._option == '$gte'
          ">= #{page._column_filt[index]._value}"
        elsif page._column_filt[index]._option == '$eq'
          "= #{page._column_filt[index]._value}"
        else
          ""
        end
      else
        ""
      end
    end
  end
end
