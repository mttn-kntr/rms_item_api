# -*- encoding: utf-8 -*-
# stub: rms_item_api 0.2.3 ruby lib

Gem::Specification.new do |s|
  s.name = "rms_item_api".freeze
  s.version = "0.2.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["t4traw".freeze]
  s.bindir = "exe".freeze
  s.date = "2017-10-25"
  s.description = "RMS\u306E\u5546\u54C1API\u3092\u7C21\u5358\u306B\u53E9\u3051\u308Bruby\u30E9\u30C3\u30D1\u30FC".freeze
  s.email = ["t4traw@gmail.com".freeze]
  s.files = [".gitignore".freeze, ".rbenv-gemsets".freeze, ".travis.yml".freeze, "Gemfile".freeze, "LICENSE".freeze, "README.md".freeze, "Rakefile".freeze, "config/response_codes.yml".freeze, "lib/rms_item_api.rb".freeze, "lib/rms_item_api/ShopManagement/get.rb".freeze, "lib/rms_item_api/cabinet.rb".freeze, "lib/rms_item_api/cabinet/delete.rb".freeze, "lib/rms_item_api/cabinet/get.rb".freeze, "lib/rms_item_api/cabinet/insert.rb".freeze, "lib/rms_item_api/cabinet/revert.rb".freeze, "lib/rms_item_api/cabinet/search.rb".freeze, "lib/rms_item_api/cabinet/update.rb".freeze, "lib/rms_item_api/category.rb".freeze, "lib/rms_item_api/category/delete.rb".freeze, "lib/rms_item_api/category/get.rb".freeze, "lib/rms_item_api/category/insert.rb".freeze, "lib/rms_item_api/category/move.rb".freeze, "lib/rms_item_api/category/update.rb".freeze, "lib/rms_item_api/coupon.rb".freeze, "lib/rms_item_api/coupon/delete.rb".freeze, "lib/rms_item_api/coupon/get.rb".freeze, "lib/rms_item_api/coupon/issue.rb".freeze, "lib/rms_item_api/coupon/search.rb".freeze, "lib/rms_item_api/coupon/update.rb".freeze, "lib/rms_item_api/helper.rb".freeze, "lib/rms_item_api/item.rb".freeze, "lib/rms_item_api/item/delete.rb".freeze, "lib/rms_item_api/item/get.rb".freeze, "lib/rms_item_api/item/insert.rb".freeze, "lib/rms_item_api/item/search.rb".freeze, "lib/rms_item_api/item/update.rb".freeze, "lib/rms_item_api/navigation.rb".freeze, "lib/rms_item_api/navigation/get.rb".freeze, "lib/rms_item_api/product.rb".freeze, "lib/rms_item_api/product/search.rb".freeze, "lib/rms_item_api/shop_management.rb".freeze, "lib/rms_item_api/version.rb".freeze, "rms_item_api.gemspec".freeze]
  s.homepage = "https://github.com/t4traw/rms_item_api".freeze
  s.rubygems_version = "2.6.11".freeze
  s.summary = "RMS\u306E\u5546\u54C1API\u3092\u7C21\u5358\u306B\u53E9\u3051\u308Bruby\u30E9\u30C3\u30D1\u30FC".freeze

  s.installed_by_version = "2.6.11" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<faraday>.freeze, [">= 0.12.1"])
      s.add_runtime_dependency(%q<activesupport>.freeze, [">= 4.2.8"])
      s.add_runtime_dependency(%q<activemodel>.freeze, [">= 4.2.8"])
      s.add_runtime_dependency(%q<builder>.freeze, [">= 0"])
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.10"])
      s.add_development_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_development_dependency(%q<minitest>.freeze, ["~> 5.0"])
      s.add_development_dependency(%q<minitest-reporters>.freeze, [">= 0"])
      s.add_development_dependency(%q<webmock>.freeze, [">= 0"])
      s.add_development_dependency(%q<vcr>.freeze, [">= 0"])
      s.add_development_dependency(%q<dotenv>.freeze, [">= 0"])
      s.add_development_dependency(%q<pry>.freeze, [">= 0"])
    else
      s.add_dependency(%q<faraday>.freeze, [">= 0.12.1"])
      s.add_dependency(%q<activesupport>.freeze, [">= 4.2.8"])
      s.add_dependency(%q<activemodel>.freeze, [">= 4.2.8"])
      s.add_dependency(%q<builder>.freeze, [">= 0"])
      s.add_dependency(%q<bundler>.freeze, ["~> 1.10"])
      s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
      s.add_dependency(%q<minitest>.freeze, ["~> 5.0"])
      s.add_dependency(%q<minitest-reporters>.freeze, [">= 0"])
      s.add_dependency(%q<webmock>.freeze, [">= 0"])
      s.add_dependency(%q<vcr>.freeze, [">= 0"])
      s.add_dependency(%q<dotenv>.freeze, [">= 0"])
      s.add_dependency(%q<pry>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<faraday>.freeze, [">= 0.12.1"])
    s.add_dependency(%q<activesupport>.freeze, [">= 4.2.8"])
    s.add_dependency(%q<activemodel>.freeze, [">= 4.2.8"])
    s.add_dependency(%q<builder>.freeze, [">= 0"])
    s.add_dependency(%q<bundler>.freeze, ["~> 1.10"])
    s.add_dependency(%q<rake>.freeze, ["~> 10.0"])
    s.add_dependency(%q<minitest>.freeze, ["~> 5.0"])
    s.add_dependency(%q<minitest-reporters>.freeze, [">= 0"])
    s.add_dependency(%q<webmock>.freeze, [">= 0"])
    s.add_dependency(%q<vcr>.freeze, [">= 0"])
    s.add_dependency(%q<dotenv>.freeze, [">= 0"])
    s.add_dependency(%q<pry>.freeze, [">= 0"])
  end
end
