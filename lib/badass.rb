require 'net/http'
require 'json'
require 'date'

# Contains a few constants used across BD's site, and a few helper methods.
module BadASS
  # A hash of API mappings of number to firmness.
  FIRMNESSES = { '2' => 'Extra Soft', '3' => 'Soft', '5' => 'Medium', '8' => 'Firm', '3/5' => 'Soft Shaft, Med Base', '5/3' => 'Soft Shaft, Med Base', '3/8' => 'Soft Shaft, Firm Base', '8/3' => 'Soft Shaft, Firm Base', '5/8' => 'Med Shaft, Firm Base', '8/5' => 'Med Shaft, Firm Base' }.freeze
  # A hash of API mappings to correctly capitalize a size.
  SIZES = { 'onesize' => 'One-Size', 'mini' => 'Mini', 'small' => 'Small', 'medium' => 'Medium', 'large' => 'Large', 'extralarge' => 'Extra Large' }.freeze
  # A hash of API mappings of toy SKU to toy name.
  BAD_DRAGON_SKUS = JSON.parse(Net::HTTP.get(URI('https://bad-dragon.com/api/inventory-toy/product-list'))).map { |toy| { toy['sku'] => toy['name'] } }.reduce({}, :update)

  # Get the current sales on the site.
  # @return [Array<BadASS::Sale>]
  def self.sales
    JSON.parse(Net::HTTP.get(URI('https://bad-dragon.com/api/sales'))).map do |sale|
      BadASS::Sale.new(sale)
    end
  end

  # Get the current drops on the site.
  # @return [Array<BadASS::Toy>]
  def self.drops
    page = 1
    toy_list = []
    loop do
      newtoys = JSON.parse(Net::HTTP.get(URI("https://bad-dragon.com/api/inventory-toys?price[min]=0&price[max]=300&noAccessories=false&cumtube=false&suctionCup=false&sort[field]=price&&sort[direction]=asc&page=#{page}&limit=60")))
      page += 1
      newtoys['toys'].each do |toy|
        toy_list << BadASS::Toy.new(toy)
      end
      break if page > newtoys['totalPages']
    end
    toy_list
  end
end

require 'badass/client'
require 'badass/toy'
require 'badass/sale'
