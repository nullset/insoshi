module SetTainted

  def self.included(klass)
    klass.extend ClassMethods
  end

  def set_tainted
    if self.changed? && (!self.changes.include?('tainted') || self.tainted != false)
      self.tainted = true
    end
  end
  
  def tainted?
    tainted
  end
  
  module ClassMethods
  end
  
end