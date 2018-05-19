require 'net/http'
require 'json'

module BadASS
  FIRMNESSES = { '2' => 'Extra Soft', '3' => 'Soft', '5' => 'Medium', '8' => 'Firm', '3/5': 'Soft Shaft, Med Base', '5/3' => 'Soft Shaft, Med Base', '3/8' => 'Soft Shaft, Firm Base', '8/3' => 'Soft Shaft, Firm Base', '5/8' => 'Med Shaft, Firm Base', '8/5' => 'Med Shaft, Firm Base' }
  SIZES = { 'onesize' => 'One-Size', 'mini' => 'Mini', 'small' => 'Small', 'medium' => 'Medium', 'large' => 'Large', 'extralarge' => 'Extra Large' }

  @baddragon_skus = {}
  JSON.parse(Net::HTTP.get(URI('https://bad-dragon.com/api/inventory-toy/product-list'))).each do |toy|
    @baddragon_skus[toy['sku']] = toy['name']
  end
  BAD_DRAGON_SKUS = @baddragon_skus
end

require 'badass/client'
require 'badass/toy'
