class TasksController < ApplicationController
    before_action :set_course
    before_action :set_task, only: [:show, :edit, :update]

    def new
        @task = @course.tasks.build
    end
    
    def create
        @task = @course.tasks.build(task_params)
        
        if @task.save
            redirect_to [@course, @task], notice: 'Task saved.'
        else
            flash.now[:alert] = 'Task not saved.'
            render :new
        end
    end

    def show
    end

    private
      def set_course
          @course = Course.find(params[:course_id])
      end

      def set_task
        @task = @course.tasks.find(params[:id])
      end
      
      def task_params
        params.require(:task).permit(:name, :due_date)
      end
end