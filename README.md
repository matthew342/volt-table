# Volt-table

volt-table provides a table with pagination, search, sorting, and filtering.

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

### Using without a block (No click events)

In your controller, set up a page._table hash:


    before_action :set_default_table_options, only: :index

    def set_default_table_options
       params._sort_field ||= "last_name"
       params._sort_direction ||= 1
       page._table = {
           columns: [
                {title: "First Name", search_field: 'first', field_name: 'first_name', sort_name: 'first_name', shown: true},
                {title: "Last Name", search_field: 'last', field_name: 'last_name', sort_name: 'last_name', shown: true},
                {title: "Email", search_field: 'email', field_name: 'email', sort_name: 'email', shown: true},
           ]
        }
    end

In your views, set up a table tag

    <:table source="{{ store.users.all }}" />

#### Options
Use `params._sort_field ||=` to set the default column to be sorted and `params._sort_direction ||=` (1 or -1) for the sort direction. Sorted alphabetical and numerical

#####Required Column fields
`title: 'field name'` The title used for the column header

`field_name: 'field name'` The field name used in the model.

`shown: <true or false>` The visibility of the column in the default table load.

#####Optional Column fields
`search_field: 'field name'` Enables searching for terms in this column. the 'field name' will be what the user enters as a query when you want to limit the search to only that column. ex: `search_field: 'name'` will be queried for in the search bar as `name: Bob Smith`. Only terms with the search_field defined will be searched in the search bar

`sort_name: 'field name'`  adds ability for column to be sorted and filtered

`sort_reverse: true` initial sorting order is in reverse

#### Attributes
`source=` passes the data to the table

### Using with a block (click events)
In your controller, set up a page._table hash:


    before_action :set_default_table_options, only: :index

    def set_default_table_options
       params._sort_field ||= "last_name"
       params._sort_direction ||= 1
       page._table = {
           default_click_event: 'user_click',
           columns: [
                {title: "First Name", search_field: 'first', field_name: 'first_name', sort_name: 'first_name', shown: true},
                {title: "Last Name", search_field: 'last', field_name: 'last_name', sort_name: 'last_name', shown: true},
                {title: "Email", search_field: 'email', field_name: 'email', sort_name: 'email', click_event: 'email_click', shown: true},
           ]
        }
    end

    def user_clicked
        #Some action here
    end

    def email_clicked
        #Some action here
    end


The two additional methods will be run when a user clicks on a row or clicks on a specific column of the row

In Views, add the table block with the attributes for both click events on the table:main:body tag


     <:table:headers />  
     <:table:wrapper>
         <:table:columns />
         <:table:main:body source="{{ store.users.all }}" e-user_click="user_clicked" e-email_click="email_clicked"/>
     </:table:wrapper>
     <:table:main:footers source="{{ store.users.all }}" />

#### Additional Options with block
`default_click_event: 'some_action'` trigger this event when a row in the table is clicked

`click_event: 'some_action'` triggers this event when this column in the row is selected.


## Valid Search Queries

The search bar uses simple boolean queries to search for data. Simply enter in a word or phrase and the table will search for all tokens that match any column. `,` is used for ANDing two queries and `|` is used to OR two queries. Ex:

`Bob Smith` will return all rows that match any column to Bob Smith

`Bob Smith | Chicago` will return rows that match any column to Bob Smith OR Chicago

`Bob Smith, Chicago` returns rows that match any column to Bob Smith AND Chicago

`first: Bob, last: Smith, city: Chicago` only returns rows that match first name Bob, last name Smith AND city Chicago



## Contributing

1. Fork it ( http://github.com/matthew342/volt-table/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
