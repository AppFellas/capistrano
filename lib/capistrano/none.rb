load File.expand_path("../tasks/svn.rake", __FILE__)

require 'capistrano/scm'
  
class Capistrano::None < Capistrano::SCM  
  
      def svn(*args)
        args.unshift(:svn)
        context.execute *args
      end
  
      module DefaultStrategy
        def test
          true
        end
    
        def check
          true
        end
    
        def clone
          #svn :checkout, repo_url, repo_path
        end
    
        def update
          #svn :update
        end
    
        def release
          #svn :export, '.', release_path
        end
      end  
end