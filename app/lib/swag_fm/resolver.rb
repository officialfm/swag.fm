module SwagFm
  class Resolver
    attr_reader :url

    def self.new_from_url(url)
      case url
      when /official\.fm/ then OfficialFm.new(url)
      when /soundcloud\.com/ then SoundCloud.new(url)
      else raise NotImplementedError.new(url)
      end
    end

    def initialize(url)
      @url = url
    end

    class OfficialFm < Resolver

      def track
        @track ||= OfficialFM::Client.new(api_key: '4qpH1KdXhJF64NPD3zdK7t2gpTF8vHHz').track(url.split('/').last, fields: 'cover,streaming')
      end

      def cover_url
        track.cover.urls.medium
      end

      def stream_url
        track.streaming.http
      end

      def duration
        track.duration
      end

      def artist
        track.artist
      end

      def title
        track.title
      end

      def origin_url
        track.page
      end
    end

    class SoundCloud < Resolver

      def track
        @track ||= ::Soundcloud.new(client_id: '880faec8a616cb8ddc4fc35fe410b644').get('/resolve', url: url)
      end

      def cover_url
        track.artwork_url.sub('-large.', '-t200x200.')
      end

      def stream_url
        track.stream_url
      end

      def duration
        track.duration
      end

      def artist
        track.user.username
      end

      def title
        track.title
      end

      def origin_url
        track.permalink_url
      end
    end
  end
end