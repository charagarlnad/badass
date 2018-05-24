# A client to periodically check for new toys and news to avoid spamming the BD API directly.
class BadASS::Client
  # Creates a client to do API operations.
  # @param refresh_rate [Integer] the rate at which the Client should refresh its list of toys.
  def initialize(refresh_rate: 600)
    Thread.new do
      @drops = BadASS.drops
      @sales = BadASS.sales
      sleep(refresh_rate)
    end
  end

  # @return [Array<BadASS::Toy>] the current drops
  attr_reader :drops
  # @return [Array<BadASS::Sale>] the current BD sales
  attr_reader :sales
end
