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
      attrs = '(?:\[.*\])'
      pseudos = '(?:\:\w+)'
      @selector.scan(/([a-z_]+(?:#{attrs}|#{pseudos})*)/i).flatten \
        .reject { |css| css.blank? } \
        .map { |css| Fragment.new(css.to_s) }
    end
  end
end
