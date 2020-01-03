class SmartAssetsWorker
  include Sidekiq::Worker

  def self.run_job(url)
    SmartAndFastAssets.log "#{self.class} -> run_job -> #{url}"
    case SmartAndFastAssets.execution
    when :inline
      new.perform(url)
    when :background
      perform_async(url)
    else
      raise 'incorrect value'
    end
  end

end
