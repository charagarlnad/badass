class BadASS::Client
  # Creates a client to do operations.
  # Takes a :refresh_time argument to define how often the toy list should be refreshed.
  def initialize(refresh_time: 600)
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
        sleep(refresh_time)
      end
    end
  end

  attr_reader :toys
end
