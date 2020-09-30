namespace :deploy do
  task :cleanup do
    # Do nothing
  end
  after 'deploy:updated', 'deploy:cleanup'
end
