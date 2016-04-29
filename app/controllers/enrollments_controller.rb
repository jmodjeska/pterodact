class EnrollmentsController < ApplicationController

    def index
        load_enrollments
    end

    def new
        build_enrollment
    end

    def create
        build_enrollment
        save_enrollment('Enrollment successfully created.', @enrollment) ||
            fail_to_save('Enrollment was not saved.', :new)
    end

    def show
        load_enrollment
    end

    def edit
        load_enrollment
        build_enrollment
    end

    def update
    end

    private
        def load_enrollments
            @enrollments ||= enrollment_scope.to_a
        end

        def load_enrollment
            @enrollment ||= enrollment_scope.find(params[:id])
        end

        def build_enrollment
            @enrollment ||= enrollment_scope.build
            @enrollment.attributes = enrollment_params
        end

        def save_enrollment(message, target)
            if @enrollment.save
                redirect_to target, notice: message
            end
        end

        def fail_to_save(message, render_target)
            if message
                flash.now[:alert] = message
            end
            render render_target
        end

        def enrollment_params
            enrollment_params = params[:enrollment]
            enrollment_params ? enrollment_params.permit(
                :offer_date_id,
                :student_id
            ) : {}
        end

        def enrollment_scope
          Enrollment.all
        end
end
