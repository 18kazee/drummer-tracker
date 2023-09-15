require 'rails_helper'

RSpec.describe Artist, type: :model do
  describe 'バリデーション' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'アソシエーション' do
    it { is_expected.to have_many(:drummer_artists).dependent(:destroy) }
    it { is_expected.to have_many(:drummers).through(:drummer_artists) }
  end
end
