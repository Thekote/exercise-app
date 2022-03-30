class ExercisesController < ApplicationController
  before_action :set_exercise, only: %i[ show edit update destroy ]

  def index
    @exercises = Exercise.all
  end

  def show
  end

  def new
    @exercise = Exercise.new
  end

  def create
    @exercise = Exercise.new(exercise_params)

    return render :new, status: :unprocessable_entity unless @exercise.save
    redirect_to @exercise, notice: "Exercise was successfully created."
  end

  def edit
  end

  def update
    return render :edit, status: :unprocessable_entity unless @exercise.update(exercise_params)
    redirect_to @exercise, notice: "Exercise was successfully updated."
  end

  def destroy
    @exercise.destroy

    redirect_to exercises_url, notice: "Exercise was successfully destroyed."
  end

  private
    def set_exercise
      @exercise = Exercise.find(params[:id])
    end

    def exercise_params
      params.require(:exercise).permit(:name, :description, :power_level)
    end
end
