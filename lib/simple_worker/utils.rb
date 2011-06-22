module SimpleWorker

  def self.check_for_file(f)
        f = f.to_str
        unless ends_with?(f, ".rb")
          f << ".rb"
        end
        exists = false
        if File.exist? f
          exists = true
        else
          # try relative
          #          p caller
          f2 = File.join(File.dirname(caller[3]), f)
#          puts 'f2=' + f2
          if File.exist? f2
            exists = true
            f = f2
          end
        end
        unless exists
          raise "File not found: " + f
        end
        f = File.expand_path(f)
        require f
        f
      end

end