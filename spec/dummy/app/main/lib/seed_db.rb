require_relative '../../../../factories'
require 'ruby-progressbar'

num_users = 5

progressbar = ProgressBar.create
progressbar.total = 1 + num_users

#create Custom Users, used for testing


# Create several more users
# steps = num_users
Factories.custom_user({method: :save}, 'Bob', 'Smith')
progressbar.increment

Factories.custom_user({method: :save}, 'Jerry', 'Smith')
progressbar.increment

Factories.custom_user({method: :save}, 'Bob', 'Barker')
progressbar.increment

Factories.custom_user({method: :save}, 'Jerry', 'Sienfeld')
progressbar.increment

Factories.custom_user({method: :save}, 'Mary', 'Joe')
progressbar.increment
