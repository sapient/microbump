require 'spec_helper'

describe User do
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:password) }
  it { should have_many(:posts) }

  it { should have_db_column(:email) }
  it { should have_db_column(:name) }
  it { should have_db_column(:about) }
  it { should allow_mass_assignment_of(:password) }
  it { should allow_mass_assignment_of(:password_confirmation) }
end
