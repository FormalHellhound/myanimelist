module MyAnimeList
  class Anime

    def initialize(options={})
      @myanimelist_username = options[:username]
      @myanimelist_password = options[:password]
    end

    def search(name)
      query = name      
      query.split(' ')
      name = ''
      query.each do |query|
        name += "q=#{query}&"
      end
      get_search(name)
    end

    def get_search(name)
      response = RestClient::Request.new(
        method: :get,
        url: "https://myanimelist.net/api/anime/search.xml?#{CGI::escape name}",
        user: @myanimelist_username,
        password: @myanimelist_password,
        content_type: :xml ).execute

      parse_xml response
    end

    def parse_xml(response)
      serialize Hash.from_xml response
    end

    def serialize(data)
      result = MyAnimeList::Serializer.new data, 'anime'
      result.fetch
    end

  end
end
