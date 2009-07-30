module SetTainted

  def self.included(klass)
    klass.extend ClassMethods
  end

  def set_tainted
    logger.info "=======> Changed fields: #{self.changed.inspect}"
    # Fields that don't change the taitedness of a model when they are changed
    non_tainted_fields = {
      "BlogPost" => ['featured', 'position'],
      "Photo" => ['primary', 'avatar', 'size']
    }
    # if self.changed? && (!self.changes.include?('tainted') || self.tainted != false)

    # if self.changed? && (!self.changes.include?('tainted') && (self.tainted == true || self.tainted.blank?)) && !self.changes.dup.delete_if {|k,v| k == 'featured' || k == 'position'}.blank?

    if self.changed? && (!self.changes.include?('tainted') && (self.tainted == true || self.tainted.blank?)) && !self.changes.dup.delete_if {|k,v| non_tainted_fields[self.class.to_s].include?(k) }.blank?
      self.tainted = true
    end
  end
  
  def tainted?
    tainted
  end
  
  module ClassMethods
  end
  
end