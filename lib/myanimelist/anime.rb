module MyAnimeList
  class Anime

    def initialize(options={})
      @myanimelist_username = options[:username]
      @myanimelist_password = options[:password]
    end

    def search(name)
      query = name.split(' ')
      #name = "q=#{CGI::escape 'FMA'}&#{CGI::escape 'Shamballa'}"
      name = 'q='
      escape_symbol = '+'
      query.each_with_index do |q, index|
        name += "#{CGI::escape q}"
        name += "#{CGI::escape escape_symbol}" unless (index+1 == query.length)
      end
      puts name
      get_search(name)
    end

    def get_search(name)
      response = RestClient::Request.execute(
        method: :get,
        url: "https://myanimelist.net/api/anime/search.xml?#{name}",
        user: @myanimelist_username,
        password: @myanimelist_password,
        content_type: :xml)
      puts response
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
