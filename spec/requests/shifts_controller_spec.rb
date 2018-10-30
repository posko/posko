require 'rails_helper'

RSpec.describe Api::V1::ShiftsController, type: :request do
  let(:user) { create(:user) }
  let(:access_key) { user.access_keys.first }
  let(:shift) { create(:shift, starting_cash: 10, user: user) }

  let(:headers) do
    token = access_key.token
    auth_token = access_key.auth_token
    { 'HTTP_AUTHORIZATION': basic_auth(token, auth_token) }
  end

  describe 'GET /api/v1/shifts/current' do
    context 'with existing opened shift' do
      before do
        create(:shift, user: user)
        get '/api/v1/shifts/current', headers: headers
      end

      it 'returns current shift' do
        expect(json).to include_json(shift: {})

        expect(json.count).to eq(1)
      end
    end

    context 'without shift' do
      before { get '/api/v1/shifts/current', headers: headers }

      it 'returns an error message' do
        expect(json).to include_json(
          error: "You don't have any ongoing shift yet"
        )
      end
    end
  end

  describe 'POST /api/v1/shifts' do
    context 'with existing shift' do
      let(:params) do
        {
          shift: { starting_cash: 1000 }
        }
      end

      before { post '/api/v1/shifts', params: params, headers: headers }

      it 'returns current shift' do
        expect(json).to include_json(shift: { starting_cash: '1000.0' })
        expect(user.shifts.count).to eq(1)
      end
    end

    context 'without shift' do
      before do
        shift
        post '/api/v1/shifts', headers: headers
      end

      it 'returns an error message' do
        expect(json).to include_json(
          error: 'Close your current shift first'
        )
      end
    end
  end

  describe 'POST /api/v1/shifts/end_shift' do
    context 'with existing shift' do
      let(:expected) do
        {
          shift: {
            starting_cash: '10.0',
            shift_status: 'ended'
          }
        }
      end

      before do
        shift
        patch '/api/v1/shifts/end_shift', headers: headers
      end

      it 'ends the current shift' do
        expect(user.shifts.count).to eq(1)
        expect(json.count).to eq(1)
        expect(json).to include_json(expected)
      end
    end

    context 'without shift' do
      before { patch '/api/v1/shifts/end_shift', headers: headers }

      it 'returns an error message' do
        expect(json).to include_json(
          error: "You don't have any ongoing shift yet"
        )
      end
    end
  end
end
