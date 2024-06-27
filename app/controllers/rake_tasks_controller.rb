class RakeTasksController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :run
  def run
    # task_name = params[:task_name]
    # task_params = params[:task_params] || {}
    
    render json: { message: "yooo" }
  end
end
