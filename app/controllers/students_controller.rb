class StudentsController < ApplicationController

    def index
        load_students
    end

    def new
        build_student
    end

    def create
        build_student
        success_message = "Student #{@student.full_name} successfully created."
        save_student(success_message, @student) ||
            fail_to_save('Student was not saved.', :new)
    end

    def show
        load_student
    end

    def edit
        load_student
        build_student
    end

    def update
        load_student
        build_student
        save_student('Student successfully updated.', @student) ||
            fail_to_save('Student was not updated.', :edit)
    end

    def import
        s_new, s_updated = Student.import(params[:file])
        msg = "Added #{s_new} new students and updated #{s_updated} students."
        redirect_to students_url, notice: msg
    end

  private
    def load_students
        @students ||= student_scope.to_a
    end

    def load_student
        @student ||= student_scope.find(params[:id])
    end

    def build_student
        @student ||= student_scope.build
        @student.attributes = student_params
    end

    def save_student(message, target)
        if @student.save
            redirect_to target, notice: message
        end
    end

    def fail_to_save(message, render_target)
        if message
            flash.now[:alert] = message
        end
        render render_target
    end

    def student_params
        student_params = params[:student]
        student_params ? student_params.permit(
            :first_name,
            :last_name,
            :department,
            :moz_number,
            :manager_id
        ) : {}
    end

    def student_scope
        Student.all
    end
end
