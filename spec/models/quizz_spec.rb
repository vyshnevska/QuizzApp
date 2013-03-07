require 'spec_helper'

describe Quizz, "new quizz" do
  it { should have_many(:users).through(:games) }
  it { should have_many(:questions) }
  it { should have_many(:games) }
 #validators
  it { should validate_uniqueness_of(:description) }
  it { should validate_presence_of(:description) }
end
