SimpleWorker.require "gmail_xoauth"
class AwesomeJob < SimpleWorker::Base
  merge_gem 'dropbox' # , '1.2.3'
  # bumpdsfsdfdsfasdf
  merge_gem 'mongoid_i18n', :require => 'mongoid/i18n'

  def run
    begin
      s = Dropbox::Session.new('...', '...')
    rescue => ex
      log "Dropbox doesn't like it when you don't have keys"
    end

    begin
      smtp = Net::SMTP.new('smtp.gmail.com', 587)
      smtp.enable_starttls_auto
      secret = {
          :two_legged => true,
          :consumer_key => 'a',
          :consumer_secret => 'b'
      }
      smtp.start('gmail.com', 'myemail@mydomain.com', secret, :xoauth)
      smtp.finish
    rescue =>ex
      log "wwrong keys for gmail #{ex.inspect}"
    end
#    s.mode = :dropbox
#    s.authorizing_user = 'email@gmail.com'
#    s.authorizing_password = '...'
#    s.authorize!
#
#    tmp_file = Tempfile.new('myfile.txt')
#    tmp_file.write("blahblah")
#    tmp_file.close
#
#    s.upload tmp_file.path, 'Test'
#    tmp_file.unlink
  end
end
