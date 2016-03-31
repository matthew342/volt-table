require_relative '../../../../factories'
require 'ruby-progressbar'

num_users = 50

progressbar = ProgressBar.create
progressbar.total = 6 + num_users

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

num_users.times do
  Factories.user({method: :save})
  progressbar.increment
end
