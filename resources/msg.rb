def initialize(*args)
  super
  @action = :speak
end

actions :speak

attribute :nickname, :kind_of => String
attribute :token, :kind_of => String
attribute :room, :kind_of => String
attribute :message, :kind_of => [ String, FalseClass ], :default => false
attribute :failure_ok, :kind_of => [ TrueClass, FalseClass ], :default => true
attribute :notify, :kind_of => [ TrueClass, FalseClass ], :default => true
attribute :color, :kind_of => String, :default => 'yellow', :regex => /^(yellow|red|green|purple)$/
