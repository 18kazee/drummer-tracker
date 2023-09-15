require 'rails_helper'

RSpec.describe Room, type: :model do
  describe 'アソシエーション' do
    it { is_expected.to have_many(:messages).dependent(:destroy) }
    it { is_expected.to have_many(:user_rooms).dependent(:destroy) }
    it { is_expected.to have_many(:users).through(:user_rooms) }
    it { is_expected.to have_many(:posts).dependent(:destroy) }
  end
end
