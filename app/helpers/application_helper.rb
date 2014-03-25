module ApplicationHelper

  def flash_class(level)
    case level
        when :notice then "alert alert-info"
        when :success then "Data successfully added"
        when :error then "There was an error"
        when :alert then "Make sure you enter data before submitting"
    end
end
end
