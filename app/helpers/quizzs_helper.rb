module QuizzsHelper
	def page_title(name, action = nil)
		action.nil? ? content_tag("h2", name) : content_tag("h5", name)
	end
end
