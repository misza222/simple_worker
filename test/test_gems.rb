require_relative 'test_base'
require_relative 'awesome_job'


class TestGems < TestBase

  def test_dropbox_gem

    worker = AwesomeJob.new
    worker.queue

    wait_for_task(worker)
    log =  worker.get_log
    puts 'log=' + log
    assert log.include?("SMTPAuthenticationError"),"failed to merge gmail gem" # gmail authentification failed

  end

end
