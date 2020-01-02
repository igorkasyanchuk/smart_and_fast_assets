module SmartAndFastAssets
  class Engine < ::Rails::Engine

    initializer 'smart_and_fast_assets.helpers' do
      ActiveSupport.on_load :action_view do
        ActionView::Base.send :include, WebpImageHelper
      end
    end

  end
end
