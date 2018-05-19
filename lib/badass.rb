require 'net/http'
require 'json'

module BadASS
  @api_root = 'https://bad-dragon.com/api'

  def self.test
    return 'your gay lol'
  end

end

require 'badass/client'
require 'badass/fast'
