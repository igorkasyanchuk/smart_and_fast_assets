module SmartAndFastAssets
  class Engine < ::Rails::Engine

    initializer 'smart_and_fast_assets.helpers' do
      ActiveSupport.on_load :action_view do
        ActionView::Base.send :include, WebpImageHelper
      end

      require_relative '../../app/workers/analyze_image_worker.rb'
    end

  end
end
