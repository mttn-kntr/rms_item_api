module RmsItemApi
  module Cabinet
    include RmsItemApi::Helper

    def cabinet_file_insert(item_data)
      request_xml = {itemInsertRequest: {item: item_data}}.to_xml(
        root: 'request', camelize: :lower, skip_types: true
      )
      response = connection('1.0/cabinet/file/', 'insert').post {|r| r.body = request_xml}
      handler response
    end
  end
end
