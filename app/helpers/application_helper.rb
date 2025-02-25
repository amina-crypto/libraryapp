module ApplicationHelper
  def flash_class(type)
    case type.to_sym
    when :notice, :success
      'is-success'
    when :alert, :error
      'is-danger'
    when :warning
      'is-warning'
    else
      'is-info'
    end
  end

  def flash_icon(type)
    case type.to_sym
    when :notice, :success
      'fa-check-circle'
    when :alert, :error
      'fa-exclamation-circle'
    when :warning
      'fa-exclamation-triangle'
    else
      'fa-info-circle'
    end
  end
end
