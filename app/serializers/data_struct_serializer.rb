class DataStructSerializer
  def self.dump(hash)
    hash.to_json
  end

  def self.load(hash)
    return unless hash
    JSON.parse(hash, object_class: DataStruct)
  end
end
