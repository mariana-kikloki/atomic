class ActivitiesController < ApplicationController
  before_action :set_activities, only: [:show, :edit, :update, :destroy]
  layout 'welcome'

  def new
    @activity = Activity.new
  end

  def index
    @activities = Activity.all.paginate(page: params[:page], per_page: 5)
    if params[:department].present?
      dep = Department.find_by(title: params[:department])
      @activities = Activity.where(department_id: dep.id).paginate(page: params[:page], per_page: 5)
    end
  end

  def department
    department = Department.find_by(title: params[:department]).id
    @activities = Activity.where(department_id: department).paginate(page: params[:page], per_page: 5)
  end

  def show
  end

  def create
    @activity = Activity.new(activity_params)
    if @activity.save
      redirect_to @activity
    else
      render :new
    end
  end

  def update
    if @activity.update(activity_params)
      redirect_to @activity
    else
      render :edit
    end
  end

  def destroy
    @activity.destroy
    redirect_to @activity
  end

  private
    def activity_params
      params.require(:activity).permit(:name, :location, :description, :total_rating, :member_cost, :guest_cost, :start_date, :end_date, :coffee_break, :poster, :department_id)
    end

    def set_activities
      @activity = Activity.find(params[:id])
    end

end
