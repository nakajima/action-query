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
      @filters = selector.scan(/:(\w+)/).flatten
      @selector = selector.split(':').first
    end

    def results
      proxy = model.scoped(:conditions => conditions)
      @filters.inject(proxy) do |res,filter|
        res.__send__(filter)
      end
    end

    def model
      @selector.match(/^(\w+)/).to_s.classify.constantize
    end

    def conditions
      @conditions ||= begin
        attrs = Hash[*attributes]
        attrs.merge!(:id => id) if id
        attrs
      end
    end

    private

    def id
      @id ||= begin
        __id__ = @selector.match(/\#(.*)/).to_s
        __id__ =~ /^\s*$/ ? nil : __id__[1..-1]
      end
    end

    def attributes
      @attributes ||= begin
        @selector.scan(/\[(.*)\]/).flatten \
          .map { |str| str.split(%r/=|(\]\[)/) }.flatten \
          .map { |str| str.gsub(/(\A("|')|("|')\Z)/, '') } \
          .reject { |str| str =~ %r/=|(\]\[)/ }
      end
    end
  end

  def fragments
    @fragments ||= begin
      ids = '(?:\#.*)'
      attrs = '(?:\[.*\])'
      pseudos = '(?:\:\w+)'
      @selector.scan(/([a-z_]+(?:#{ids}|#{attrs}|#{pseudos})*)/i).flatten \
        .reject { |css| css.blank? } \
        .map { |css| Fragment.new(css.to_s) }
    end
  end
end
