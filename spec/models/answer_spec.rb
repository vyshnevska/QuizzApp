require 'rails_helper'

describe Answer do
  it { expect belong_to :question }
  it { should validate_presence_of(:content).with_message(I18n.translate('validation.content')) }

  it 'has a valid factory' do
    expect(build(:answer)).to be_valid
  end

  it 'is invalid without a content' do
    expect(build(:answer, :content => nil)).to_not be_valid
  end
end
