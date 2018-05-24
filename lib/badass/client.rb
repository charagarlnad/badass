# A client to periodically check for new toys.
class BadASS::Client
  # Creates a client to do API operations.
  # @param refresh_rate [Integer] the rate at which the Client should refresh its list of toys.
  def initialize(refresh_rate: 600)
    Thread.new do
      @toys = []
      loop do
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
        @toys = toy_list
        sleep(refresh_rate)
      end
    end
  end

  # @return [Array<String>] the current toys on the BD API
  attr_reader :toys
end
