require 'net/http'
require 'json'
require 'date'

# https://gist.github.com/chetan/1827484
module BadASS
  FIRMNESSES = { '2' => 'Extra Soft', '3' => 'Soft', '5' => 'Medium', '8' => 'Firm', '3/5' => 'Soft Shaft, Med Base', '5/3' => 'Soft Shaft, Med Base', '3/8' => 'Soft Shaft, Firm Base', '8/3' => 'Soft Shaft, Firm Base', '5/8' => 'Med Shaft, Firm Base', '8/5' => 'Med Shaft, Firm Base' }.freeze
  SIZES = { 'onesize' => 'One-Size', 'mini' => 'Mini', 'small' => 'Small', 'medium' => 'Medium', 'large' => 'Large', 'extralarge' => 'Extra Large' }.freeze

  @baddragon_skus = {}
  JSON.parse(Net::HTTP.get(URI('https://bad-dragon.com/api/inventory-toy/product-list'))).each do |toy|
    @baddragon_skus[toy['sku']] = toy['name']
  end
  BAD_DRAGON_SKUS = @baddragon_skus.freeze

  # Gets the current sales. Returns a hash of sales.
  def self.sales
    JSON.parse(Net::HTTP.get(URI('https://bad-dragon.com/api/sales'))).map do |sale|
      BadASS::Sale.new(sale)
    end
  end
end

require 'badass/client'
require 'badass/toy'
require 'badass/sale'
