class CountTask < Volt::Task
  def count(filter)
    Volt::DataStore.fetch.db['dentists'].find(filter).count
  end
end
