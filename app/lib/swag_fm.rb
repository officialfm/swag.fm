module SwagFm
  def self.official
    require 'officialfm'
    @official ||= OfficialFM::Client.new
  end
end
