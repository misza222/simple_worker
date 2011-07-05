SimpleWorker.require_relative 'cool_model'
class CoolWorker < SimpleWorker::Base
  attr_accessor :array_of_models
  def run
    10.times do |i|
      puts "HEY THERE PUTS #{i}"
      log "HEY THERE LOG #{i}"
      sleep 1
    end
  end
end
