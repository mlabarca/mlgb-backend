require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe '.from_user_email' do
    let(:email) { Faker::Internet.email }
    let(:other_email) { Faker::Internet.email }
    let(:favorite_count) { 3 }

    before do
      create_list(:favorite, favorite_count, email: email)
      create(:favorite, email: other_email)
    end

    it 'filters favorites from a specific user' do
      favorites = Favorite.from_user_email(email)

      expect(favorites.length).to eq(favorite_count)
      expect(favorites.pluck(:email).uniq).to eq [email]
      expect(favorites.pluck(:email)).not_to include other_email
    end
  end
end
