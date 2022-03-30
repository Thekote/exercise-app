class RoutinesController < ApplicationController
  before_action :set_routine, only: %i[ show edit update destroy ]
  skip_before_action :authenticate_user!, only: %i[ index ]
  def index
    @routines = Routine.all
  end

  def show
  end

  def new
    @routine = Routine.new
  end

  
  def create
    @routine = Routine.new(routine_params)
    
    return render :edit, status: :unprocessable_entity unless @routine.save
    redirect_to @routine, notice: "Routine was successfully created."    
  end
  
  def edit
  end

  def update
    return render :edit, status: :unprocessable_entity unless @routine.update(routine_params)
    redirect_to @routine, notice: "Routine was successfully updated."
  end

  def destroy
    @routine.destroy

    redirect_to routines_path, notice: "Routine was successfully destroyed."
  end

  private
    def set_routine
      @routine = Routine.find(params[:id])
    end

    def routine_params
      params.require(:routine).permit(:name, exercise_ids: [])
    end
end
