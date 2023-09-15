require 'rails_helper'

RSpec.describe Drummer, type: :model do
  describe 'バリデーション' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:country) }
  end

  describe 'アソシエーション' do
    it { is_expected.to have_many(:drummer_genres).dependent(:destroy) }
    it { is_expected.to have_many(:genres).through(:drummer_genres) }
    it { is_expected.to have_many(:drummer_artists).dependent(:destroy) }
    it { is_expected.to have_many(:artists).through(:drummer_artists) }
    it { is_expected.to have_many(:posts).dependent(:destroy) }
    it { is_expected.to have_many(:recommended_drummers).dependent(:destroy) }
    it { is_expected.to have_many(:favorites).dependent(:destroy) }
  end

  describe 'enums' do
    subject(:drummer) { build(:drummer) }

    it '国のenumが正しく定義されていること' do
      expect(drummer).to define_enum_for(:country).with_values(japan: 0, abroad: 1)
    end
  end
end
