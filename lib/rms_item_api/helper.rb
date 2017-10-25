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
      status_parser(rexml)
      case response.env.method
      when :get
        get_response_parser(rexml)
      # when :post
      #   post_response_parser(rexml)
      end
      self
    end

    private

    def encoded_key
      if @serviceSecret.blank? && @licenseKey.blank?
        error_msg = "serviceSecret and licenseKey are required"
        raise StandardError, error_msg
      else
        "ESA " + Base64.strict_encode64(@serviceSecret + ":" + @licenseKey)
      end
    end

    def get_endpoint(rexml)
      result = {}
      interfaceId = rexml.elements["result/status/interfaceId"].text
      dot_count = interfaceId.count(".")
      result[:api] = interfaceId.split('.')[dot_count-1]
      result[:method] = interfaceId.split('.')[dot_count]
      result[:camel] = "#{result[:api]}#{result[:method].capitalize}"
      result
    end

    def status_parser(rexml)
      # p "status_parserにきたよーーーーーーーーーーー"
      # endpoint = get_endpoint(rexml)
      # if endpoint[:api] == "item"
      #   xpoint = "result/#{endpoint[:camel]}Result/code" # origin
      # elsif endpoint[:api] == "category"
      #   xpoint = "result/#{endpoint[:camel]}Result/code" # origin
      # elsif endpoint[:api] == "genre"
      #   xpoint = "result/navigation#{endpoint[:api].capitalize}GetResult/genre"
      # elsif endpoint[:api] == "cabinet"
      #   p "cabinet---------"
      #   xpoint = "result/#{endpoint[:api]}FoldersGetResult"
      # elsif endpoint[:api] == "coupon"
      #   xpoint = "result/#{endpoint[:api]}"
      # elsif endpoint[:api] == "shop_management"
      #   p "shop_managementにきたよーーーーーー"
      #   xpoint = "result/delvAreaMasterList"
      # end
      # p xpoint
      # p "xpointが見れてるよーーーーーーーーーーーー！"
      # response_code = rexml.elements[xpoint].text
      #
      # yml = "#{File.dirname(__FILE__)}/../../config/response_codes.yml"
      # response_codes = YAML.load_file(yml)
      #
      # self.define_singleton_method(:is_success?) { response_code == 'N000' ? true : false }
      # self.define_singleton_method(:message) { response_codes[response_code] }
      # err_point = "result/#{endpoint[:camel]}Result/errorMessages/errorMessage/msg"
      # err_msg = []
      # rexml.elements.each(err_point) do |element|
      #   err_msg << element.text
      # end
      # self.define_singleton_method(:errors) { err_msg }
      # p "err_msg=#{err_msg}"
      # p "is_success?を通過するよーー？？？？？？？？？？？"
      # self.is_success?
      # p "is_success?を通過しましたーーーーーーーーーーーー"
    end

    def get_response_parser(rexml)
      endpoint = get_endpoint(rexml)
      if endpoint[:api] == "item"
        xpoint = "result/#{endpoint[:camel]}Result/#{endpoint[:api]}" # original code
      elsif endpoint[:api] == "category"
        xpoint = "result/#{endpoint[:camel]}Result/#{endpoint[:api]}"
      elsif endpoint[:api] == "genre"
        xpoint = "result/navigation#{endpoint[:api].capitalize}GetResult/#{endpoint[:api]}" # genre無理やり
      elsif endpoint[:api] == "folders" || endpoint[:api] == "files"
        xpoint = "result/cabinet#{endpoint[:api].capitalize}GetResult"
      elsif endpoint[:api] == "coupon"
        xpoint = "result/#{endpoint[:api]}"
      elsif endpoint[:api] == "asuraku"
        xpoint = "result/delvAreaMasterList/delvdateMaster"
      end
      rexml.elements.each(xpoint) do |result|
        result.children.each do |el|
          next if el.to_s.strip.blank?
          if el.has_elements?
            begin
              elif = self.define_singleton_method(el.name.underscore) {
                Hash.rakuten_from_xml(el.to_s)
              }
              p result
            rescue => e
              puts e
            end
          else
            begin
              elelse = self.define_singleton_method(el.name.underscore) {
                el.text.try!(:force_encoding, 'utf-8')
              }
            rescue => e
              puts e
            end
          end
        end
      end
      self
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
