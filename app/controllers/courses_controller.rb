class CoursesController < ApplicationController
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
        @course = Course.find(params[:id])
    end
    
    private
        def course_params
            params.require(:course).permit(:name, :catalog, :description, :offer_date, :size)
        end
end