class CoursesController < ApplicationController
    before_action :set_course, only: [:show, :update, :edit]
    
    def index
        @courses = Course.all
    end

    def new
        @course = Course.new
    end
    
    def create
        @course = Course.new(course_params)
        if @course.save
            redirect_to @course, notice: 'Course successfully created.'
        else
            flash.now[:alert] = 'Course was not saved.'
            render :new
        end
    end

    def show
        @offer_dates = @course.offer_dates.all
        @students = @course.students.all
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
            params.require(:course).permit(:name, :catalog, :description)
        end
        
        def set_course
          @course = Course.find(params[:id])
        end        
end