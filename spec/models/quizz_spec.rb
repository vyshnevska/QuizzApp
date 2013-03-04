require 'spec_helper'

describe Quizz, "new quizz" do
 # it { should belong_to(:user) }
  it { should have_many(:users).through(:games) }
  it { should have_many(:questions) }
  it { should have_many(:games) }
end
