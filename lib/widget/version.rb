module Widget
  module VERSION # :nodoc:
    MAJOR  = 0
    MINOR  = 0
    TINY   = 3
    PRE    = nil

    STRING = [MAJOR, MINOR, TINY, PRE].compact.join('.')

    SUMMARY = "Widget #{STRING}"
  end
end
