module SetTainted

  def self.included(klass)
    klass.extend ClassMethods
  end

  def set_tainted
    # if self.changed? && (!self.changes.include?('tainted') || self.tainted != false)
    if self.changed? && (!self.changes.include?('tainted') && (self.tainted == true || self.tainted.blank?)) && !self.changes.dup.delete_if {|k,v| k == 'featured' || k == 'position'}.blank?
      self.tainted = true
    end
  end
  
  def tainted?
    tainted
  end
  
  module ClassMethods
  end
  
end