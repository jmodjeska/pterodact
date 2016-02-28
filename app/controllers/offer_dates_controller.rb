class OfferDatesController < ApplicationController
    before_action :set_course
    before_action :set_offer_date, only: [:show, :edit, :update]

    def new
        @offer_date = @course.offer_dates.build
    end
    
    def create
        @offer_date = @course.offer_dates.build(offer_date_params)
        
        if @offer_date.save
            redirect_to [@course, @offer_date], notice: 'Offer date saved.'
        else
            flash.now[:alert] = 'Offer date not saved.'
            render :new
        end
    end

    def show
    end

    private
      def set_course
          @course = Course.find(params[:course_id])
      end

      def set_offer_date
        @offer_date = @course.offer_dates.find(params[:id])
      end
      
      def offer_date_params
        params.require(:offer_date).permit(:date, :size)
      end
end