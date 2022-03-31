require 'rails_helper'

RSpec.describe '/routines', type: :request do
  let(:lunges) { Exercise.create!(description: 'Lunges', power_level: 2) }
  let(:stepup) { Exercise.create!(description: 'Step-ups', power_level: 8) }
  
  let(:valid_attributes) {
    { :name => 'Leg Day', :exercise_ids => [lunges.id, stepup.id] }
  }
  
  describe 'GET /index' do
    it 'returns a successful response' do
      Routine.create! valid_attributes
      get routines_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET /show' do
    before do
      @user = User.create(email: 'user@example.com', password: 'qwerty')
      sign_in(@user)
    end

    it 'returns a successful response' do
      routine = Routine.create! valid_attributes
      get routine_path(routine)
      expect(response).to have_http_status(:success)
    end

    context 'when the user is not logged in' do
      it 'redirects to log in page' do
        routine = Routine.create! valid_attributes
        sign_out(@user)
        
        get routine_path(routine)
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'returns a ok http status' do
        routine = Routine.create! valid_attributes
        get routine_path(routine)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET /new' do
    before do
      @user = User.create(email: 'user@example.com', password: 'qwerty')
      sign_in(@user)
    end

    it 'returns a successful response' do
      get new_routine_path
      expect(response).to have_http_status(:success)
    end

    context 'when the user is not logged in' do
      it 'redirects to log in page' do
        routine = Routine.create! valid_attributes
        sign_out(@user)
        
        get routine_path(routine)
        expect(response).to redirect_to(new_user_session_path)
      end

      it 'returns a ok http status' do
        routine = Routine.create! valid_attributes
        get routine_path(routine)
        expect(response).to have_http_status(:ok)
      end
    end
  end

  describe 'GET /edit' do
    before do
      @user = User.create(email: 'user@example.com', password: 'qwerty')
      sign_in(@user)
    end

    it 'returns a successful response' do
      routine = Routine.create! valid_attributes
      get edit_routine_path(routine)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST /create' do
    before do
      @user = User.create(email: 'user@example.com', password: 'qwerty')
      sign_in(@user)
    end

    context 'with valid parameters' do
      it 'creates a new Routine' do
        expect {
          post routines_path, params: { routine: valid_attributes }
        }.to change(Routine, :count).by(1)
      end

      it 'redirects to the created routine' do
        post routines_path, params: { routine: valid_attributes }
        expect(response).to redirect_to(routine_path(Routine.last))
      end
    end
  end

  describe 'PATCH /update' do
    before do
      @user = User.create(email: 'user@example.com', password: 'qwerty')
      sign_in(@user)
    end

    context 'with valid parameters' do
      let(:new_attributes) {
        { :name => 'Monday' }
      }

      it 'updates the requested routine' do
        routine = Routine.create! valid_attributes
        patch routine_path(routine), params: { routine: new_attributes }
        routine.reload
        expect(response).to have_http_status(:found)
        expect(routine.name).to eq('Monday')
      end

      it 'redirects to the routine' do
        routine = Routine.create! valid_attributes
        patch routine_path(routine), params: { routine: new_attributes }
        routine.reload
        expect(response).to redirect_to(routine_path(routine))
      end
    end
  end

  describe 'DELETE /destroy' do
    before do
      @user = User.create(email: 'user@example.com', password: 'qwerty')
      sign_in(@user)
    end

    it 'destroys the requested routine' do
      routine = Routine.create! valid_attributes
      expect {
        delete routine_path(routine)
      }.to change(Routine, :count).by(-1)
    end

    it 'redirects to the routines list' do
      routine = Routine.create! valid_attributes
      delete routine_path(routine)
      expect(response).to redirect_to(routines_path)
    end
  end
end
