
class TasksController < ApplicationController
  include Databasedotcom::Rails::Controller
  before_filter :validate, :only => :create

  def index
    @tasks = Task.all()[0..19]
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def create
    task = Task.new(params[:task])
    task.IsRecurrence = false
    task.IsReminderSet = false
    task.Priority = "Normal"
    user = User.first
    task.OwnerId = user.Id
    begin
      if (task.save)
        redirect_to(task, :notice => 'Task was successfully created.')
      end
    rescue Databasedotcom::SalesForceError => e
      redirect_to(tasks_path, :notice => "Error creating task: #{e.message}")
    end
  end

  def destroy
    task = Task.find(params[:id])
    task.delete
    redirect_to(tasks_path, :notice => "Task '#{task.Subject}' was successfully deleted.")
  end

  private

  def validate
    @task = Task.new(params[:task])
    flash[:notice] = "Error"
    render :action => :new
  end
end
