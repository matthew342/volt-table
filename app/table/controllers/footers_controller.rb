module Table
  class FootersController < Volt::ModelController

    def start_offset
      (((params._page || 1).to_i - 1) * params._per_page.to_i)
    end

    def last_item
      range = start_offset + params._per_page.to_i
      attrs.table_size.then do |size|
        if range >= size
          size
        else
          range
        end
      end
    end
  end
end
