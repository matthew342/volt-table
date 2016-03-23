# By default Volt generates this controller for your Main component
module Main
  class MainController < Volt::ModelController
    before_action :set_default_table_options, only: :index

    def index
      # Add code for when the index view is loaded
    end

    def about
      # Add code for when the about view is loaded
    end

    def set_default_table_options
      params._sort_field ||= "last_name"
      params._sort_direction ||= 1
      page._table = {
        default_click_event: 'user_click',
        columns: [
          {title: "First Name", search_field: 'first', field_name: 'first_name', sort_name: 'first_name', shown: true},
          {title: "Last Name", search_field: 'last', field_name: 'last_name', sort_name: 'last_name', shown: true},
        ]
      }
    end

    def all_users
      store.users.all
    end

    private

    # The main template contains a #template binding that shows another
    # template.  This is the path to that template.  It may change based
    # on the params._component, params._controller, and params._action values.
    def main_path
      "#{params._component || 'main'}/#{params._controller || 'main'}/#{params._action || 'index'}"
    end

    # Determine if the current nav component is the active one by looking
    # at the first part of the url against the href attribute.
    def active_tab?
      url.path.split('/')[1] == attrs.href.split('/')[1]
    end
  end
end
