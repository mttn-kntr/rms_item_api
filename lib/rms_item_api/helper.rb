module RmsItemApi
  module Helper

    ENDPOINT = 'https://api.rms.rakuten.co.jp/es/'.freeze
    def connection(url, method)
      Faraday.new(url: ENDPOINT + url + method) do |conn|
        conn.adapter(Faraday.default_adapter)
        conn.headers['Authorization'] = encoded_key
      end
    end

    def convert_xml_into_json(xml)
      Hash.rakuten_from_xml(xml)
    end

    def handler(response)
      rexml = REXML::Document.new(response.body)
      self.define_singleton_method(:all) { convert_xml_into_json(response.body) }
      if rexml.elements["result/status/systemStatus"].text == "NG"
        raise rexml.elements["result/status/message"].text
      end
      case response.env.method
      when :get
        item_response_parser(rexml)
      # when :post
      #   post_response_parser(rexml)
      end  
    end

    def encoded_key
      if @serviceSecret.blank? && @licenseKey.blank?
        error_msg = "serviceSecret and licenseKey are required"
        raise StandardError, error_msg
      else
        "ESA " + Base64.strict_encode64(@serviceSecret + ":" + @licenseKey)
      end
    end

    def get_result_endpoint(rexml)
      result = {}
      interfaceId = rexml.elements["result/status/interfaceId"].text
      dot_count = interfaceId.count(".")
      result[:api] = interfaceId.split('.')[dot_count-1]
      result[:method] = interfaceId.split('.')[dot_count]
      result[:camel] = "#{result[:api]}#{result[:method].capitalize}"
      result
    end

    def get_request_endpoint(rexml)
      request = {}
      interfaceId = rexml.elements["request/status/interfaceId"].text
      dot_count = interfaceId.count(".")
      request[:api] = interfaceId.split('.')[dot_count-1]
      request[:method] = interfaceId.split('.')[dot_count]
      request[:camel] = "#{request[:api]}#{request[:method].capitalize}"
      result
    end

    def item_response_parser(rexml)
      endpoint = get_result_endpoint(rexml)
      # ------------------------ItemAPI------------------------------------
      case endpoint[:api]
      when "item"
        api_type = "item"
        case endpoint[:method]
        when "get"
          xpoint = "result/#{endpoint[:camel]}Result/#{endpoint[:api]}"
          singular_operate(rexml,xpoint, api_type)
        when "insert"
          xpoint = "result/#{endpoint[:camel]}Result/#{endpoint[:api]}"
          singular_operate(rexml,xpoint, api_type)
        when "update"
          xpoint = "result/#{endpoint[:camel]}Result/#{endpoint[:api]}"
          singular_operate(rexml,xpoint, api_type)
        when "delete"
          xpoint = "result/#{endpoint[:camel]}Result/#{endpoint[:api]}"
          singular_operate(rexml,xpoint, api_type)
        when "search"
          xpoint = "result/#{endpoint[:camel]}Result/items/#{endpoint[:api]}"
          multiple_operate(rexml, xpoint, api_type)
        end
      # ------------------------ProductAPI---------------------------------
      # 一旦とばす
      # when "product"
      #   xpoint = "result/#{endpoint[:camel]}Result/products/#{endpoint[:api]}"
      # ------------------------CabinetAPI--------------------------------
      when "usage"
        api_type = "cabinet"
        xpoint = "result/cabinet#{endpoint[:camel]}Result"
        singular_operate(rexml, xpoint, api_type)
      when "folders"
        api_type = "cabinet"
        xpoint = "result/cabinetFoldersGetResult/#{endpoint[:api]}/folder"
        multiple_operate(rexml, xpoint, api_type)
      when "files"
        api_type = "cabinet"
        case endpoint[:method]
        when "get"
          xpoint = "result/cabinetFolder#{endpoint[:camel]}Result/files/file"
          multiple_operate(rexml, xpoint, api_type)
        when "search"
          xpoint = "result/cabinetFilesSearchResult/files/file"
          multiple_operate(rexml, xpoint, api_type)
        # when "get"
        #  xpoint = "result/cabinetTrashbox#{endpoint[:camel]}Result/files/file"
        end
      when "file"
        api_type = "cabinet"
        case endpoint[:method]
        when "revert"
          xpoint = "request/#{endpoint[:camel]}Request/file"
        when "delete"
          xpoint = "request/#{endpoint[:camel]}Request/file"
        when "insert"
          xpoint = "request/#{endpoint[:camel]}Request/file"
          singular_operate(rexml, xpoint, api_type)
        when "update"
          xpoint = "request/#{endpoint[:camel]}Request/file"
        end
      when "folder"
        if endpoint[:method] == "insert"
          xpoint = "request/#{endpoint[:camel]}Request/file"
        end
      # ------------------------NavigationAPI------------------------------
      # 一旦とばす
      # when "genre"
      #   xpoint = "result/navigation#{endpoint[:camel]}Result/genre"
      # when "tag"
      #   xpoint = "result/navigationGenre#{endpoint[:camel]}Result/genre"
      # when "header"
      #   xpoint = "result/navigationGenreTagGetResult"
      # ------------------------CategoryAPI---------------------------------
      when "categorysets"
        xpoint = "result/#{endpoint[:camel]}Result/categorySetList/categorySet"
        multiple_operate(rexml, xpoint)
      when "categories"
        xpoint = "result/#{endpoint[:camel]}Result/categoryList/category"
      when "category"
        case endpoint[:method]
        when "get"
          xpoint = "result/#{endpoint[:camel]}Result/#{endpoint[:api]}"
        when "insert"
          xpoint = "result/#{endpoint[:camel]}Result/#{endpoint[:api]}"
        when "update"
          xpoint = "request/#{endpoint[:camel]}Request/#{endpoint[:api]}"
        when "delete"
          xpoint = "request/#{endpoint[:camel]}Request/#{endpoint[:api]}"
        when "move"
          xpoint = "request/#{endpoint[:camel]}Request"
        end
      # -----------------------CouponAPI(coupon)---------------------------
      # 一旦とばす
      # when "coupon"
      #   case endpoint[:method]
      #   when "issue"
      #     xpoint = "request/#{endpoint[:camel]}Request/#{endpoint[:api]}"
      #   when "update"
      #     xpoint = "request/#{endpoint[:camel]}Request/#{endpoint[:api]}"
      #   when "delete"
      #     xpoint = "request/#{endpoint[:camel]}Request/#{endpoint[:api]}"
      #   when "get"
      #     xpoint = "result/#{endpoint[:api]}"
      #   when "search"
      #     xpoint = "result/coupons/#{endpoint[:api]}"
      #   end
      # -----------------------CouponAPI(thankscoupon)---------------------
      # 一旦とばす
      # when "thankscoupon"
      #   case endpoint[:method]
      #   when "issue"
      #     xpoint = "request/#{endpoint[:method].capitalize}"
      #   when "update"
      #     xpoint = "request/#{endpoint[:method].capitalize}"
      #   when "stop"
      #     xpoint = "result/#{endpoint[:method].capitalize}"
      #   when "get"
      #     xpoint = "result/#{endpoint[:method].capitalize}"
      #   when "search"
      #     xpoint = "result/#{endpoint[:method].capitalize}"
      #   end
      # -----------------------ShopManagementAPI---------------------------
      when "segment"
        case endpoint[:method]
        when "get"
          xpoint = ""
        end
      when "list"
      when "asuraku"
        xpoint = "result/delvAreaMasterList/delvdateMaster"
      end
    end

    # 元々あったxmlパースコードをメソッドにして一旦ここに保持
    def parse_xpoint_element(rexml, xpoint)
      rexml.elements.each(xpoint) do |result|
        result.children.each do |el|
          next if el.to_s.strip.blank?
          if el.has_elements?
            sample = self.define_singleton_method(el.name.underscore) {              
              Hash.rakuten_from_xml(el.to_s)
            }
          else
            sample = self.define_singleton_method(el.name.underscore) {
             el.text.try!(:force_encoding, 'utf-8')
            }
          end
        end
      end
    end

    # １つの商品を操作する場合に利用
    def singular_operate(rexml, xpoint, api_type)
      case api_type
      when "item"
        # parse_xpoint_element(rexml, xpoint)
        rexml.elements.each(xpoint) do |result|
          result.children.each do |el|
            next if el.to_s.strip.blank?
             sample = self.define_singleton_method(el.name.underscore) {
              el.text.try!(:force_encoding, 'utf-8')
            }
          end
        end
      when "cabinet"
        rexml.elements.each(xpoint) do |result|
          result.children.each do |el|
            next if el.to_s.strip.blank?
             sample = self.define_singleton_method(el.name.underscore) {
              el.text.try!(:force_encoding, 'utf-8')
            }
          end
        end
      end
      self
    end

    # 複数の商品を操作する場合に利用
    def multiple_operate(rexml, xpoint, api_type)
      if api_type == "item"
        array = []
          rexml.elements.each(xpoint) do |result|
            result.children.each do |el|
              next if el.to_s.strip.blank?
              if el.has_elements?
                begin
                  elif = self.define_singleton_method(el.name.underscore) {
                    p Hash.rakuten_from_xml(el.to_s)
                  }
                  p array.push(item_name)
                rescue => e
                    puts e
                end
              else
                begin
                  elelse = self.define_singleton_method(el.name.underscore) {
                    el.text.try!(:force_encoding, 'utf-8')
                  }
                  # p array.push(item_name)
                rescue => e
                  puts e
                end
              end
            end
          end
        else api_type == "cabinet"
          array = []
          rexml.elements.each(xpoint) do |result|
            result.children.each do |el|
              next if el.to_s.strip.blank?
              if el.has_elements?
                begin
                  elif = self.define_singleton_method(el.name.underscore) {
                    p Hash.rakuten_from_xml(el.to_s)
                  }
                  # p array.push(folder_name)
                rescue => e
                    puts e
                end
              else
                begin
                  elelse = self.define_singleton_method(el.name.underscore) {
                    el.text.try!(:force_encoding, 'utf-8')
                  }
                  p array.push(file_name)
                rescue => e
                  puts e
                end
              end
            end
          end
        end
      array
    end


    def post_response_parser(rexml)
      self
    end
  end
end

class Hash
  class << self

    def rakuten_from_xml(rexml)
      r = from_xml(rexml)
      xml_elem_to_hash r.root
    end

    private

    def xml_elem_to_hash(el)
      value = if el.has_elements?
        children = {}
        el.each_element do |e|
          children.merge!(xml_elem_to_hash(e)) do |k,v1,v2|
            v1.is_a?(Array) ?  v1 << v2 : [v1,v2]
          end
        end
        children
      else
        el.text
      end
      { el.name.to_sym => value }
    end
  end
end
