module RmsItemApi
  module Item
    include RmsItemApi::Helper

    
    # def item_search(item_name,
    #                 catch_copy,
    #                 item_url,
    #                 catalog_id,
    #                 genre_id,
    #                 item_price_from,
    #                 item_price_to,
    #                 depot_flg,
    #                 item_mobile_flg,
    #                 limited_flg,
    #                 postage_flg,
    #                 off_set,
    #                 limit,
    #                 sort_key,
    #                 sort_order)
    #   request_xml = {itemSearchResult: {items: { item1: item_name, item2: catch_copy, item3: item_url, item4: catalog_id, item5: genre_id, item6: item_price_from, item7: item_price_to, item8: depot_flg, item9: item_mobile_flg, item10: limited_flg, item11: postage_flg, item12: off_set, item13: limit, item14: sort_key, item15: sort_order}}}.to_xml(
    #     root: 'result', camelize: :lower, skip_types: true
    #   )
    #   response = connection('1.0/item/', 'search').get { |r|
    #     r.params['itemName'] = item_name
    #     r.params['catchcopy'] = catch_copy
    #     r.params['itemUrl'] = item_url
    #     r.params['catalogId'] = catalog_id
    #     r.params['genreId'] = genre_id
    #     r.params['itemPriceFrom'] = item_price_from
    #     r.params['itemPriceTo'] = item_price_to
    #     r.params['depotFlg'] = depot_flg
    #     r.params['itemMobileFlg'] = item_mobile_flg
    #     r.params['limitedFlg'] = limited_flg
    #     r.params['postageFlg'] = postage_flg
    #     r.params['offset'] = off_set
    #     r.params['limit'] = limit
    #     r.params['sortKey'] = sort_key
    #     r.params['sortOrder'] = sort_order
    #   }
    #   handler response
    # end

    def item_search(item_name, offset, limit)
      response = connection('1.0/item/', 'search').get { |r| 
        r.params['itemName'] = item_name 
        r.params['offset'] = offset
        r.params['limit'] = limit
        # r.params['itemUrl'] = item_url 
      }
      handler(response)
    end

  end
end
