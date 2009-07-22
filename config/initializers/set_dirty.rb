module SetDirty

  def self.included(klass)
    klass.extend ClassMethods
  end

  def set_dirty
    if self.changed? && (!self.changes.include?('dirty') || self.dirty != false)
      self.dirty = true
    end
  end
  
  module ClassMethods
  end
  
end