class StudentsController < ApplicationController
    before_action :set_student, only: [:show, :update, :edit]

    def index
        @students = Student.all
    end

    def new
        @student = Student.new
    end

    def create
        @student = Student.new(student_params)
        if @student.save
            redirect_to @student, notice: 'Student successfully created.'
        else
            flash.now[:alert] = 'Student was not saved.'
            render :new
        end
    end
    
    def show 
        @student = Student.find(params[:id])
    end
    
    def edit
    end
    
    def update
        if @student.update(student_params)
            redirect_to @student, notice: 'Student successfully updated.'
        else
            flash.now[:alert] = 'Student was not updated.'
            render :edit
        end
    end

  private
    def student_params
      params.require(:student).permit(:first_name, :last_name, :title, :department, :moz_number)
    end
    
    def set_student
      @student = Student.find(params[:id])
    end
end