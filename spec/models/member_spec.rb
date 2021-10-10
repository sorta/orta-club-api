require 'rails_helper'

RSpec.describe Member, type: :model do
  it { should validate_presence_of(:name_first) }
end
