class BadASS::Sale
  # Create a Sale object using a hash from the API.
  def initialize(sale_hash)
    @title = sale_hash['title']
    @description = JSON.parse(sale_hash['content'])['blocks'].map { |x| x['text'] }.join("\n")
    @image = sale_hash['image']['url']
    @start_date = DateTime.rfc3339(sale_hash['startDate']) rescue nil
    @end_date = DateTime.rfc3339(sale_hash['endDate']) rescue nil
  end

  attr_reader :title
  attr_reader :description
  attr_reader :image
  attr_reader :start_date
  attr_reader :end_date
end
