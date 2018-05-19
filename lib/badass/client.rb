class BadASS::Client
  # Creates a client to do operations.
  def initialize(refresh_time: 600)
    Thread.new do
      @baddragon_skus = {}
      JSON.parse(Net::HTTP.get(URI('https://bad-dragon.com/api/inventory-toy/product-list'))).each do |toy|
        @baddragon_skus[toy['sku']] = toy['name']
      end
      loop do
        start_time = Time.now
        @toys_finished = false
        page = 1
        @toys = []
        loop do
          newtoys = JSON.parse(Net::HTTP.get(URI("https://bad-dragon.com/api/inventory-toys?price[min]=0&price[max]=300&noAccessories=false&cumtube=false&suctionCup=false&sort[field]=price&&sort[direction]=asc&page=#{page}&limit=60")))
          newtoys['toys'].each do |toy|
            toy['name'] = @baddragon_skus[toy['sku']]
          end
          page += 1
          @toys.concat(newtoys['toys'])
          break if page > newtoys['totalPages']
        end
        @toys_finished = true
        puts (Time.now - start_time) * 1000
        sleep(refresh_time)
      end
    end
  end

  def toys
    sleep(0.1) until @toys_finished
    @toys
  end
end
