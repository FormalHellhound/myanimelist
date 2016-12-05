module MyAnimeList
  class Anime

    def initialize(options={})
      @myanimelist_username = options[:username]
      @myanimelist_password = options[:password]
    end

    def search(name)
      query = name.split(' ')
      name = 'q=FMA&q=Brotherhood'
      #query.each_with_index do |query, index|
        #name += "q=#{query}"
        #name += "&" unless (index == query.size - 1)
      #end
      puts name
      get_search(name)
    end

    def get_search(name)
      response = RestClient::Request.new(
        method: :get,
        url: "https://myanimelist.net/api/anime/search.xml?#{name}",
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
