require "./example_helper"

@turn_limit = 100

def test1
  # info = Parser.parse(Pathname("katomomo.kif").read, turn_limit: @turn_limit)
  # object = info.image_formatter({width: 100, height: 100})
  # object.to_png[0..3]           # => 
end

def test2
  info = Parser.parse(Pathname("katomomo.kif").read, {
      :turn_limit                     => @turn_limit,
      # :skill_monitor_enable           => false,
      # :skill_monitor_technique_enable => false,
      :candidate_skip                 => true,
      :validate_enable                  => false,
      :mediator_class                 => MediatorFast,
    })
  object = info.image_formatter({width: 100, height: 100})
  object.to_png[0..3]           # => "\x89PNG", "\x89PNG", "\x89PNG", "\x89PNG", "\x89PNG"
end

require "active_support/core_ext/benchmark"
def _; "%7.2f ms" % Benchmark.ms { 5.times { yield } } end
_ { test1 } # => "   0.01 ms"
_ { test2 } # => " 391.99 ms"
