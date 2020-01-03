class GeneralWorker

  def self.run_job(klass, url)
    SmartAndFastAssets.log "#{klass} -> run_job -> #{url} (#{SmartAndFastAssets.execution})"
    case SmartAndFastAssets.execution
    when :inline
      klass.new.perform(url)
    when :background
      klass.perform_async(url)
    else
      raise 'incorrect value'
    end
    nil
  end

end
