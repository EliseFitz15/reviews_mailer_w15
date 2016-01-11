require 'rails_helper'

RSpec.describe Pokemon do
  it { should belong_to(:user) }
  it { should have_many(:reviews) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:ability) }
  it { should validate_presence_of(:poketype) }
end
