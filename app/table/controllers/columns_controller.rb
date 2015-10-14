module Table
  class ColumnsController < Volt::ModelController

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

  end
end
