module SwagFm
  def self.official
    @official ||= OfficialFM::Client.new
  end
end
