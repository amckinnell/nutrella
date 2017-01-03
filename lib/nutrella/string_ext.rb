#
# Simpler versions of extensions from ActiveSupport.
#
class String
  def strip_heredoc
    gsub(/^ +/, "")
  end

  def titleize
    tr("_-", " ").split(" ").map(&:capitalize).join(" ")
  end
end
