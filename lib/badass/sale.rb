# Base class containing a Bad Dragon sale and it's attributes.
class BadASS::Sale
  # Create a Sale object using a hash from the API.
  # @param [Hash]
  def initialize(sale_hash)
    @title = sale_hash['title']
    @description = JSON.parse(sale_hash['content'])['blocks'].map { |x| x['text'] }.join("\n")
    @image = sale_hash['image']['url']
    @start_date = Date.rfc3339(sale_hash['startDate']) rescue nil
    @end_date = Date.rfc3339(sale_hash['endDate']) rescue nil
  end

  # @return [String] the title of the sale
  attr_reader :title
  # @return [String] the description of the sale
  attr_reader :description
  # @return [String] the image URL of the sale
  attr_reader :image
  # @return [Date] the start date of the sale
  attr_reader :start_date
  # @return [Date] the end date of the sale
  attr_reader :end_date
end
