# frozen_string_literal: true

# Simpler versions of an extension from ActiveSupport.
#
class String
  def titleize
    tr("_-", " ").split.map(&:capitalize).join(" ")
  end
end
