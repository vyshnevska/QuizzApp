require 'spec_helper'

describe Answer do
  #relations
  it { should belong_to(:question) }

  #validators
  it { should validate_presence_of(:content).with_message("Answer can't be blank.") }
end
