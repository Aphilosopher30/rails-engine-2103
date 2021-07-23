class ItemCount
  attr_reader :id, :count, :name

  def initialize(id, item_count)
    @id = id
    @name = Merchant.find_by(id: id).name

    @count = count_setter(item_count)
  end

  def count_setter(item_count)
    if item_count  == nil
      @count = 0
    else
      @count = item_count
    end
  end

end
