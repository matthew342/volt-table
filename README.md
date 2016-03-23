# Volt::Table

volt-table provides a table with the ability to search, sort, and filter data.

## Installation

Add this line to your application's Gemfile:

    gem 'volt-table'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install volt-table

## Usage

### Include table in dependencies.rb

    component 'table'

### Using without a block

In your controller, set up a page._table hash:

```
before_action :set_default_table_options, only: :index

def set_default_table_options
  params._sort_field ||= "last_name"
  params._sort_direction ||= 1
  page._table = {
    default_click_event: 'user_click',
    columns: [
      {title: "First Name", search_field: 'first', field_name: 'first_name', sort_name: 'first_name', shown: true},
      {title: "Last Name", search_field: 'last', field_name: 'last_name', sort_name: 'last_name', shown: true},
      {title: "Email", search_field: 'email', field_name: 'email', sort_name: 'email', shown: true},
    ]
  }
end
```

#### Options
| Header One     | Header Two     |
| :------------- | :------------- |
| Item One       | Item Two       |


In your views, set up a table tag
```
<:table source="{{ store.users.all }}" source_name="users"/>
```
##### Attributes


### Using with a block



## Contributing

1. Fork it ( http://github.com/[my-github-username]/volt-table/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
