# app/controllers/rake_tasks_controller.rb
require 'rake'

class RakeTasksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :run

  # Load Rake tasks
  Rake.application.init
  Rake.application.load_rakefile

  def run
    task_name = params[:task_name]
    task_params = params[:task_params] || {}

    if task_name.present?
      begin
        # Convert task parameters to a JSON string
        task_params_json = task_params.to_json

        # Trigger the rake task with the provided parameters
        Rake::Task[task_name].reenable
        Rake::Task[task_name].invoke(task_name, task_params_json)

        render json: { message: 'Task executed successfully' }, status: :ok
      rescue => e
        render json: { error: e.message }, status: :unprocessable_entity
      end
    else
      render json: { error: 'Task name is required' }, status: :bad_request
    end
  end
end
