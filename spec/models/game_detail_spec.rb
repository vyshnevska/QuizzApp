require 'spec_helper'

describe GameDetail do
  #relations
  it { should belong_to(:game) }
  it { should belong_to(:question) }
  it { should belong_to(:answer) }

  #validators
  it { should validate_presence_of(:game_id).with_message("Game must be assigned.") }
  it { should validate_presence_of(:question_id).with_message("Question must be assigned.") }
  it { should validate_presence_of(:answer_id).with_message("Answer must be assigned.") }
end
