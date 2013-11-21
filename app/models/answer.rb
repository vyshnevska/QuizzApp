class Answer < ActiveRecord::Base
  attr_accessible :content
  belongs_to :question
  validates :content, :presence => {:message => "Answer can't be blank."}
  
  def is_correct?
    self.correct
  end

  def mark_as_correct
    self.correct = true
    save!
  end

  def mark_as_incorrect
    self.correct = false
    save!
  end

  # def correct_answers_by_qst qst_id
  #   Answer.where("question_id = ? AND correct = ?", qst_id, true)
  # end

end
