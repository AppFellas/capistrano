namespace :none do
  def strategy
    @strategy ||= Capistrano::None.new(self, fetch(:none_strategy, Capistrano::None::DefaultStrategy))
  end

  desc 'Check that the repo is reachable'
  task :check do
    on release_roles :all do
      strategy.check
    end
  end

  desc 'Clone the repo to the cache'
  task :clone do
    on release_roles :all do
      
      if strategy.test
        info t(:mirror_exists, at: repo_path)
      else
        within deploy_path do
          execute :mkdir, "-p", repo_path
          strategy.clone
        end
      end
    end
  end

  desc 'Pull changes from the remote repo'
  task :update => :'none:clone' do
    on release_roles :all do
      within repo_path do
        strategy.update
      end
    end
  end

  desc 'Copy repo to releases'
  task :create_release => :'none:update' do
    on release_roles :all do
      within repo_path do
        strategy.release
      end
    end
  end
end
