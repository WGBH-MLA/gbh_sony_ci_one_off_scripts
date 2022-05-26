require 'active_support/core_ext/hash/keys'

# Reset objects for debugging in console
Object.send(:remove_const, :AAPBCatalogSearch) if defined? AAPBCatalogSearch

class AAPBCatalogSearch
  attr_reader :uri, :full_url

  def initialize(full_url:)
    @full_url = CGI.unescape(full_url)
  end

  def uri
    @uri ||= URI.parse(full_url).tap do |uri|
      uri.path += ".json" unless uri.path =~ /\.json$/
    end
  end

  def set_params(**new_params)
    new_params.transform_keys! { |k| k.to_s }
    uri.query = URI.encode_www_form(params.merge(new_params).compact)
  end

  def params
    CGI.parse(uri.query)
  end

  def results(refresh: false)
    # resets results, forcing a re-query if `refresh` == true.
    @results = nil if refresh
    @results ||= begin
      # Sets params to grab the first page.
      set_params(page: 1, per_page: 100)
      all_docs = response['docs']

      # Gets the remaining number of pages from the first page response.
      total_pages = response['pages']['total_pages']

      # Gets docs for all of the remaining pages.
      (2..total_pages).each do |page|
        set_params(page: page)
        all_docs += response['docs']
      end
      all_docs.uniq
    end
  end

  def response
    JSON.parse(Net::HTTP.get(uri))['response']
  end
end

@full_url = "https://americanarchive.org/catalog?f%5Baccess_types%5D%5B%5D=digitized&f%5Bseries_titles%5D%5B%5D=Just+Jazz&page=2&per_page=100"
@search = AAPBCatalogSearch.new(full_url: @full_url)

# @search.results.map {|r| r['id'] }
