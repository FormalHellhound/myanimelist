module MyAnimeList
  class Anime

    def initialize(options={})
      @myanimelist_username = options[:username]
      @myanimelist_password = options[:password]
    end

    def search(name)
      query = name.split(' ')
      #name = "q=#{CGI::escape 'FMA'}&q=#{CGI::escape 'Shamballa'}"
      name = ''
      query.each_with_index do |q, index|
        name += "#{CGI::escape q}"
        name += '+' unless (index+1 == query.length)
      end
      puts name
      get_search(name)
    end

    def get_search(name)
      response = RestClient::Request.execute(
        method: :get,
        url: "https://myanimelist.net/search/prefix.json?type=anime&keyword=#{name}",
        user: @myanimelist_username,
        password: @myanimelist_password,
        content_type: :json)
      parse_json response
    end

    def parse_json(response)
      anime = JSON.parse(response)
      #serialize response
    end

    def serialize(data)
      result = MyAnimeList::Serializer.new data, 'anime'
      result.fetch
    end

  end
end
