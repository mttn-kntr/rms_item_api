module RmsItemApi
    module Cabinet
        include RmsItemApi::Helper

        def cabinet_files_search(file_name, offset, limit)
            response = connection('1.0/cabinet/files/', 'search').get { |r|
                r.params['fileName'] = file_name
                r.params['offset'] = offset
                r.params['limit'] = limit
            }
            handler(response)
        end
    end
end