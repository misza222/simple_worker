require_relative 'simple_worker/utils'
require_relative 'simple_worker/service'
require_relative 'simple_worker/base'
require_relative 'simple_worker/config'
require_relative 'simple_worker/used_in_worker'

module SimpleWorker
  @@logger = Logger.new(STDOUT)
  @@logger.level = Logger::INFO

  class << self
    attr_accessor :config,
                  :service,
                  :merged_gems,
                  :merged_files

    def configure()
      yield(config)
      if config && config.access_key && config.secret_key
        SimpleWorker.service ||= Service.new(config.access_key, config.secret_key, :config=>config)
      end
    end

    def config
      @config ||= Config.new
    end

    def logger
      @@logger
    end

    def api_version
      3
    end

    def require_relative(s)
      puts 'SimpleWorker.require_relative ' + s
      @merged_files ||= []
      f = SimpleWorker.check_for_file(s)
      Kernel.require_relative(f)
      @merged_files << f
    end

    def require(gem_name, version=nil)
      puts 'SimpleWorker.require ' + gem_name
      @merged_gems ||= []
      gem_info = {:name=>gem_name, :merge=>true}
      if version.is_a?(Hash)
        gem_info.merge!(version)
      else
        gem_info[:version] = version
      end
      @merged_gems << gem_info
      Kernel.require gem_info[:require] || gem_name
    end

  end

end

if defined?(Rails)
#  puts 'Rails=' + Rails.inspect
#  puts 'vers=' + Rails::VERSION::MAJOR.inspect
  if Rails::VERSION::MAJOR == 2
    require_relative 'rails2_init.rb'
  else
    require_relative 'railtie'
  end
end
