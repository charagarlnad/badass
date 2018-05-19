class BadASS::Toy
  def initialize(toy_hash)
    @id = toy_hash['id']
    @sku = toy_hash['sku']
    @size = toy_hash['size']
    @price = toy_hash['price']
    @weight = toy_hash['weight']
    @color = toy_hash['color']
    @colors = [toy_hash['color1'], toy_hash['color2'], toy_hash['color3']]
    @flop_reason = toy_hash['flop_reason'].capitalize
    @type = toy_hash['type'].capitalize
    @cumtube = toy_hash['cumtube']
    @suction_cup = toy_hash['suction_cup']
    @images = toy_hash['images'].map { |toy| toy['fullFilename'] }
  end

  def name
    BadASS::BAD_DRAGON_SKUS[sku]
  end

  def cumtube?
    @cumtube == 1
  end

  def suction_cup?
    @suction_cup == 1
  end

  attr_reader :id
  attr_reader :sku
  attr_reader :size
  attr_reader :price
  attr_reader :weight
  attr_reader :color
  attr_reader :colors
  attr_reader :flop_reason
  attr_reader :type
  attr_reader :images
end
