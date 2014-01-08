namespace :ng do
  desc "run 'grunt build' and copy the dist to public dir"
  task :build do
    system('grunt build --gruntfile webapp/Gruntfile.js')
    system('rm -rf public/*')
    system('cp -r webapp/dist/ public/')
  end
end
