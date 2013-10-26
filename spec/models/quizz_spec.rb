require 'spec_helper'

describe Quizz, "model quizz" do
  #relations
  it { should have_many(:users).through(:games) }
  it { should have_many(:questions) }
  it { should have_many(:games) }
  it { should accept_nested_attributes_for(:questions) }

  #validators
  it { should validate_uniqueness_of(:description).with_message("Quizz name must be unique.") }
  it { should validate_presence_of(:description).with_message(I18n.translate('missed_descr')) }

  context "for a created quizz" do
    before do
      @quizz = Quizz.create(:description =>"testQuizz")
    end

    it "default state should be draft" do
      @quizz.status.should eql("draft")
    end

    it "state should be completed" do
      @quizz.set_to_completed!
      @quizz.status.should eql("completed")
    end

    after do
      @quizz.destroy
    end
  end

  context "invalid quizz obj" do
    before { Quizz.create(:description =>"") }
    it { should be_invalid }
  end

end
