class CoursesController < ApplicationController

    def index
        load_courses
    end

    def new
        build_course
    end

    def create
        build_course
        save_course('Course successfully created.', @course) ||
            fail_to_save('Course was not saved.', :new)
    end

    def show
        load_course
        load_related
    end

    def edit
        load_course
        build_course
    end

    def update
        load_course
        build_course
        save_course('Course successfully updated.', @course) ||
            fail_to_save('Course was not updated.', :edit)
    end

    private
        def load_courses
            @courses ||= course_scope.to_a
        end

        def load_course
            @course ||= course_scope.find(params[:id])
        end

        def load_related
            @offer_dates ||= @course.offer_dates.all
            @students ||= @course.students.distinct
            @total_enrollment ||= @course.students.all
        end

        def build_course
            @course ||= course_scope.build
            @course.attributes = course_params
        end

        def save_course(message, target)
            if @course.save
                redirect_to target, notice: message
            end
        end

        def fail_to_save(message, render_target)
            if message
                flash.now[:alert] = message
            end
            render render_target
        end

        def course_params
            course_params = params[:course]
            course_params ? course_params.permit(
                :name,
                :catalog,
                :description
            ) : {}
        end

        def course_scope
            Course.all
        end
end
