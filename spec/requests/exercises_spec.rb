require 'rails_helper'


RSpec.describe "/exercises", type: :request do
  let(:user) { User.create(email: 'user@example.com', password: 'qwerty') }
  let(:headers) { { Authorization: sign_in(user) } }

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

  before { user.confirm }

  describe "GET /index" do
    it "renders a successful response" do
      Exercise.create! valid_attributes
      get exercises_path, headers: headers
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      exercise = Exercise.create! valid_attributes
      get exercises_path(exercise), headers: headers
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_exercise_path, headers: headers
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      exercise = Exercise.create! valid_attributes
      get edit_exercise_path(exercise), headers: headers
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Exercise" do
        expect {
          post exercises_path, headers: headers, params: { exercise: valid_attributes }
        }.to change(Exercise, :count).by(1)
      end

      it "redirects to the created exercise" do
        post exercises_path, headers: headers, params: { exercise: valid_attributes }
        expect(response).to redirect_to(exercise_path(Exercise.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Exercise" do
        expect {
          post exercises_path, headers: headers, params: { exercise: invalid_attributes }
        }.to change(Exercise, :count).by(0)
      end

      it "renders unprocessable entity response" do
        post exercises_path, headers: headers, params: { exercise: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { :power_level => 2 }
      }

      it "updates the exercise" do
        exercise = Exercise.create! valid_attributes
        patch exercise_path(exercise), headers: headers, params: { exercise: new_attributes }
        exercise.reload
        expect(response).to have_http_status(:found)
      end

      it "redirects to the exercise" do
        exercise = Exercise.create! valid_attributes
        patch exercise_path(exercise), headers: headers, params: { exercise: new_attributes }
        exercise.reload
        expect(response).to redirect_to(exercise_path(exercise))
      end
    end

    context "with invalid parameters" do
      it "renders unprocessable entity response" do
        exercise = Exercise.create! valid_attributes
        patch exercise_path(exercise), headers: headers, params: { exercise: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested exercise" do
      exercise = Exercise.create! valid_attributes
      expect {
        delete exercise_path(exercise), headers: headers
      }.to change(Exercise, :count).by(-1)
    end

    it "redirects to the exercise index" do
      exercise = Exercise.create! valid_attributes
      delete exercise_path(exercise), headers: headers
      expect(response).to redirect_to(exercises_path)
    end
  end
end
