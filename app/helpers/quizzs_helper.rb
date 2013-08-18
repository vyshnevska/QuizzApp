module QuizzsHelper
	def page_title(name, action = nil)
		action.nil? ? content_tag("h1", name) : content_tag("h3", name)
	end
end
