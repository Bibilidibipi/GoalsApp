class GoalsController < ApplicationController
  before_action :require_login
  before_action :check_user, except: :show

  def new
    @user = User.find(params[:user_id])
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id

    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash.now[:errors] = @goal.errors.full_messages
      @user = @goal.user
      render :new
    end
  end

  def show
    @goal = Goal.find(params[:id])
    @user = @goal.user
    @comments = @goal.comments
  end

  def destroy
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to user_url(@goal.user_id)
  end

  private

  def goal_params
    params.require(:goal).permit(:body, :public, :completed)
  end

  def check_user
    other_id = params[:user_id] || @goal.user_id
    redirect_to user_url(current_user) unless current_user.id == other_id.to_i
  end
end
