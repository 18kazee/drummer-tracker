require 'rails_helper'

RSpec.describe Genre, type: :model do
  describe 'バリデーション' do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe 'アソシエーション' do
    it { is_expected.to have_many(:drummer_genres).dependent(:destroy) }
    it { is_expected.to have_many(:drummers).through(:drummer_genres) }
  end
end
