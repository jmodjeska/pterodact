class EnrollmentsController < ApplicationController
    before_action :set_enrollment, only: [:show]
    
    def index
        @enrollments = Enrollment.all
    end

    def new
        @enrollment = Enrollment.new
    end
    
    def create
        @enrollment = Enrollment.new(enrollment_params)
        if @enrollment.save
            redirect_to @enrollment, notice: 'Enrollment successfully created.'
        else
            flash.now[:alert] = 'Enrollment was not saved.'
            render :new
        end
    end

    def show
    end
    
    def edit
    end

    def update
    end

    private
        def enrollment_params
            params.require(:enrollment).permit(:course_id, :student_id)
        end
        
        def set_enrollment
          @enrollment = Enrollment.find(params[:id])
        end        
end