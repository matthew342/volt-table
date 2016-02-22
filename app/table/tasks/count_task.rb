class CountTask < Volt::Task
  def count(filter)
    Volt::DataStore.fetch.db[attrs.db].find(filter).count
  end
end
