class CountTask < Volt::Task
  def count(data, filter)
    Volt::DataStore.fetch.db[data.to_s].find(filter).count
  end

  def total_count(data, filter)
    Volt::DataStore.fetch.db[data.to_s].find(filter).count
  end
end
