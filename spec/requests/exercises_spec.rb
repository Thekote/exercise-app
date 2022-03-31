require 'rails_helper'


RSpec.describe "/exercises", type: :request do
  let(:valid_attributes) {
    { :description => 'pushups',
      :power_level => 4
    }
  }

  let(:invalid_attributes) {
    { :description => '',
      :power_level => 'asdf'
    }    
  }

  describe "GET /index" do
    before do
      @user = User.create(email: 'user@example.com', password: 'qwerty')
      sign_in(@user)
    end

    it "renders a successful response" do
      Exercise.create! valid_attributes
      get exercises_path
      expect(response).to have_http_status(:success)
    end

    context 'when the user is not logged in' do
      it 'redirects to log in page' do
        Exercise.create! valid_attributes
        sign_out(@user)
        
        get exercises_path
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'returns a ok http status' do
        Exercise.create! valid_attributes
        get exercises_path
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe "GET /show" do
    before do
      @user = User.create(email: 'user@example.com', password: 'qwerty')
      sign_in(@user)
    end

    it "renders a successful response" do
      exercise = Exercise.create! valid_attributes
      get exercise_path(exercise)
      expect(response).to have_http_status(:success)
    end

    context 'when the user is not logged in' do
      it 'redirects to log in page' do
        exercise = Exercise.create! valid_attributes
        sign_out(@user)
        
        get exercise_path(exercise)
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'returns a found http status' do
        exercise = Exercise.create! valid_attributes
        sign_out(@user)

        get exercise_path(exercise)
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe "GET /new" do
    before do
      @user = User.create(email: 'user@example.com', password: 'qwerty')
      sign_in(@user)
    end

    it "renders a successful response" do
      get new_exercise_path
      expect(response).to have_http_status(:success)
    end

    context 'when the user is not logged in' do
      it 'redirects to log in page' do
        exercise = Exercise.create! valid_attributes
        sign_out(@user)
        
        get new_exercise_path
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'returns a found http status' do
        exercise = Exercise.create! valid_attributes
        sign_out(@user)

        get new_exercise_path
        expect(response).to have_http_status(:found)
      end
    end
  end

  describe "GET /edit" do
    before do
      @user = User.create(email: 'user@example.com', password: 'qwerty')
      sign_in(@user)
    end

    it "renders a successful response" do
      exercise = Exercise.create! valid_attributes
      get edit_exercise_path(exercise)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    before do
      @user = User.create(email: 'user@example.com', password: 'qwerty')
      sign_in(@user)
    end

    context "with valid parameters" do
      it "creates a new Exercise" do
        expect {
          post exercises_path, params: { exercise: valid_attributes }
        }.to change(Exercise, :count).by(1)
      end

      it "redirects to the created exercise" do
        post exercises_path, params: { exercise: valid_attributes }
        expect(response).to redirect_to(exercise_path(Exercise.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Exercise" do
        expect {
          post exercises_path, params: { exercise: invalid_attributes }
        }.to change(Exercise, :count).by(0)
      end

      it "renders unprocessable entity response" do
        post exercises_path, params: { exercise: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    before do
      @user = User.create(email: 'user@example.com', password: 'qwerty')
      sign_in(@user)
    end

    context "with valid parameters" do
      let(:new_attributes) {
        { :power_level => 2 }
      }

      it "updates the exercise" do
        exercise = Exercise.create! valid_attributes
        patch exercise_path(exercise), params: { exercise: new_attributes }
        exercise.reload
        expect(response).to have_http_status(:found)
      end

      it "redirects to the exercise" do
        exercise = Exercise.create! valid_attributes
        patch exercise_path(exercise), params: { exercise: new_attributes }
        exercise.reload
        expect(response).to redirect_to(exercise_path(exercise))
      end
    end

    context "with invalid parameters" do
      it "renders unprocessable entity response" do
        exercise = Exercise.create! valid_attributes
        patch exercise_path(exercise), params: { exercise: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    before do
      @user = User.create(email: 'user@example.com', password: 'qwerty')
      sign_in(@user)
    end

    it "destroys the requested exercise" do
      exercise = Exercise.create! valid_attributes
      expect {
        delete exercise_path(exercise)
      }.to change(Exercise, :count).by(-1)
    end

    it "redirects to the exercise index" do
      exercise = Exercise.create! valid_attributes
      delete exercise_path(exercise)
      expect(response).to redirect_to(exercises_path)
    end
  end
end
