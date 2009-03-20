require 'rubygems'
require 'activerecord'

class ActionQuery
  class << self
    def [](selector)
      new(selector).results
    end
  end
  
  def initialize(selector)
    @selector = selector
  end
  
  def results
    fragments.inject([]) do |res, fragment|
      fragment.results
    end
  end
  
  class Fragment
    def initialize(selector)
      @selector = selector
    end
    
    def results
      model.all(:conditions => conditions)
    end
    
    def model
      @selector.match(/^\w+/).to_s.classify.constantize
    end
    
    def conditions
      Hash[*attributes]
    end
    
    private
    
    def attributes
      @attributes ||= begin
        @selector.scan(/\[(.*)\]/).flatten \
          .map { |str| str.split(%r/=|(\]\[)/) }.flatten \
          .reject { |str| str =~ %r/=|(\]\[)/ }
      end
    end
  end
  
  def fragments
    @fragments ||= begin
      @selector.scan(/(\w+(?:\[.*\])*)/).flatten.map { |css| Fragment.new(css.to_s) }
    end
  end
end