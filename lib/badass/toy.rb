class BadASS::Toy
  def initialize(toy_hash)
    @id = toy_hash['id'] || 000000
    @title = video_hash[:title] || 'N/A'
    @url = video_hash[:webpage_url] || 'N/A'
    @thumbnail_url = video_hash[:thumbnail] || Bot::HBOT.profile.avatar_url
    @like_count = video_hash[:like_count] || 'N/A'
    @dislike_count = video_hash[:dislike_count] || 'N/A'
    @view_count = video_hash[:view_count] || 'N/A'
    @length = video_hash[:duration] || 0
    @location = video_hash[:filename] + '.mp4'
    @loop = false
    @event = event
    @skipped_time = 0
    @filters = video_hash[:filters] || []
  end
end
