class CoursesController < ApplicationController
    before_action :set_course, only: [:show, :update, :edit]
    
    def index
        @courses = Course.all
    end

    def new
        @course = Course.new
    end
    
    def create
        # Creates don't have templates
        @course = Course.new(course_params)
        if @course.save
            redirect_to @course, notice: 'Course successfully created.'
        else
            render :new
        end
    end

    def show
    end
    
    def edit
    end

    def update
        if @course.update(course_params)
          redirect_to @course, notice: 'Course successfully updated.'
        else
          render :edit
        end    
    end

    private
        def course_params
            params.require(:course).permit(:name, :catalog, :description, :offer_date, :size)
        end
        
        def set_course
          @course = Course.find(params[:id])
        end        
end