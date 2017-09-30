require_relative 'src/console'
require 'rake/testtask'

SRC_DIR  = 'src'
TEST_DIR = 'tests'


Rake::TestTask.new do |t|
  t.test_files = FileList[TEST_DIR+'/test_*.rb']
end

task :default => :start

task :start do
  Console.start
end
