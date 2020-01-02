class ApplicationController < ActionController::Base
  before_action :log_db

  def log_db
    x = WebpAsset.count
    y = SmartAsset.count
    puts "====================================================================="
    puts "==> STATUS:"
    puts "==> WebpAssets: #{x}, SmartAssets: #{y}"
    puts "====================================================================="
  end
end
