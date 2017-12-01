module RmsItemApi
  module Cabinet
    include RmsItemApi::Helper

    def cabinet_usage_get
      response = connection('1.0/cabinet/usage/', 'get').get
      handler response
    end

    def cabinet_folders_get(offset, limit)
      response = connection('1.0/cabinet/folders/', 'get').get { |r|
        r.params['offset'] = offset
        r.params['limit'] = limit
      }
      handler(response)
    end

    def cabinet_folder_files_get(folder_id, offset, limit)
      response = connection('1.0/cabinet/folder/files/', 'get').get {|r|
        r.params['folderId'] = folder_id
        r.params['offset'] = offset
        r.params['limit'] = limit
      }
      handler(response)
    end

    def cabinet_trashbox_files_get(offset, limit)
      response = connection('1.0/cabinet/trashbox/files/', 'get').get { |r|
        r.params['offset'] = offset
        r.params['limit'] = limit
      }
      handler response
    end
  end
end
