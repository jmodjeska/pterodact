class UsersController < ApplicationController

  def index
    load_users
  end

  def new
    build_user
  end

  def create
    build_user
    save_user('User successfully created.', @user) ||
      fail_to_save('User was not created.', :new)
  end

  def show
    load_user
  end

  def edit
    load_user
  end

  def update
    load_user
    build_user
    save_user('User successfully updated.', @user) ||
      fail_to_save('User was not updated.', :edit)
  end

  private
    def load_users
      @users ||= user_scope.to_a
    end

    def load_user
      @user ||= user_scope.find(params[:id])
    end

    def build_user
      @user ||= user_scope.build
      @user.attributes = user_params
    end

    def save_user(message, target)
      if @user.save
        redirect_to target, notice: message
      end
    end

    def fail_to_save(message, render_target)
      if message
        flash.now[:alert] = message
      end
      render render_target
    end

    def user_params
      user_params = params[:user]
      user_params ? user_params.permit(
        :name,
        :email,
        :password,
        :password_confirmation
      ) : {}
    end

    def user_scope
      User.all
    end
end
