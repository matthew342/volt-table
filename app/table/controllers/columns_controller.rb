module Table
  class ColumnsController < Volt::ModelController
    reactive_accessor :options
    reactive_accessor :values

    def index
      `$(document).on('click', '.dropdown-menu', function(e) {
        if ($(this).hasClass('keep-open-on-click')) {
          e.stopPropagation();
        }
      });`
      page._column_filt = []
    end

    def sort(field)
      toggle_sort_direction(field)
      params._sort_field = field
    end

    def sort_direction(reverse)
      if reverse
        params._sort_direction.to_i == 1 ? 'down' : 'up'
      else
        params._sort_direction.to_i == 1 ? 'up' : 'down'
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

    def apply_filters(item)
      page._column_filt = page._column_filt.reject { |h| item.to_s.include? h._col }
      unless options == nil || values == nil || options == '' || values == ''
        page._column_filt << {col: "#{item}", option: "#{options}", value: "#{values}" }
      end
    end

    def reset(item)
      options = ""
      values = ""
      if page._column_filt.any? { |x| x._col == item.to_s }
        page._column_filt = page._column_filt.reject { |h| item.to_s.include? h._col }
      end
    end
  end
end
