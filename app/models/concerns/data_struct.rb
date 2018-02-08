class DataStruct < OpenStruct
  def method_missing(method_name, *arguments, &block)
    if @table[:table].respond_to?(method_name)
      @table[:table].send(method_name)
    else
      super
    end
  end
end
