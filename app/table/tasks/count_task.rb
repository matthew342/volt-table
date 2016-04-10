class CountTask < Volt::Task
  def count(data, filter)
    puts "Volt::DataStore.fetch.db[#{data.to_s}].find(#{filter})"
    res = Volt::DataStore.fetch.db[data.to_s].find(filter).count
    puts res
    res
  end

  def total_count(data, filter)
    puts "Volt::DataStore.fetch.db[#{data.to_s}].find(#{filter})"
    res = Volt::DataStore.fetch.db[data.to_s].find(filter).count
    puts res
    res
  end
end
