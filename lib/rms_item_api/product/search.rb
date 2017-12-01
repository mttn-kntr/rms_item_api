module RmsItemApi
  module Product
    include RmsItemApi::Helper

    # def product_get(item_data)
    #   response = connection('1.0/item/', 'get').get {|r| r.params['itemUrl'] = item_data}
    #   handler response
    # end

    # def product_search(product_id, keyword, genre_id, maker_name, release_data_from, release_date_to, sort_by, offset, limit)
    #   response = connection('2.0/product/', 'search').get { |r| 
    #     r.params['productId'] = product_id
    #     r.params['keyword'] = keyword
    #     r.params['genreId'] = genre_id
    #     r.params['makerName'] = maker_name
    #     r.params['releaseDateFrom'] = release_date_from
    #     r.params['releaseDateTo'] = release_date_to
    #     r.params['sortBy'] = sort_by 
    #     r.params['offset'] = offset
    #     r.params['limit'] = limit
    #   }
    #   handler(response)
    # end

    def product_search(product_id, keyword)
      response = connection('2.0/product/', 'search').get { |r| 
        r.params['productId'] = product_id
        r.params['keyword'] = keyword
        # r.params['offset'] = offset
        # r.params['limit'] = limit
      }
      handler(response)
    end
  end
end
