# lib/tasks/print_task.rake
namespace :custom do
  desc "Prints the name of the task and the params object"
  task :print_params, [:task_name, :params] => :environment do |t, args|
    # Convert the JSON string of params back to a hash
    params = JSON.parse(args[:params]) rescue {}

    puts "Task Name: #{args[:task_name]}"
    puts "Params: #{params.inspect}"
  end
end
