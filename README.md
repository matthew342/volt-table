# WORK IN PROGRESS
*Not ready for use*

# Volt::Table

TODO: Write a gem description

## Installation

Add this line to your application's Gemfile:

    gem 'volt-table'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install volt-table

## Usage

### Using without a block

In your controller, set up a ```FIX ME``` hash:
```
before_action :set_default_table_options, only: :index

def set_default_table_options
  params._sort_field ||= "last_name"
  params._sort_direction ||= 1
# FIX
   = {
    search_fields: [:first_name, :last_name],
    columns: [
    {title: "External ID", field_name: "external_id", shown: false},
    {title: "External Family ID", field_name: "external_family_id", shown: false},
    {title: "First Name", field_name: "first_name", shown: true},
    {title: "Last Name", field_name: "last_name", shown: true},
    {title: "Date of Birth", field_name: 'formatted_dob', sort_name: 'birthdate', sort_reverse: true, shown: true},
    {title: "Age", field_name: "age", sort_name: 'birthdate', shown: true},
    {title: "Last Visit", field_name: "last_visit", shown: true},
    {title: "Family Balance", field_name: "family_balance", shown: false},
    {title: "Status", field_name: "status", shown: true}
    ]
  }
end
```
#### Options
| Field | Description | Options |
| search_fields | An array of fields to be searched. | [:field, :field], nil |
| columns | An array of column definitions | {title: "Field Title", field_name: 'field_name', sort_name: 'field_sort_name', shown: false} |



<:table source="{{ store.something }}" />

### Using with a block



## Contributing

1. Fork it ( http://github.com/[my-github-username]/volt-table/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
