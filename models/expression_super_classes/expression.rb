class Expression
  attr_accessor :args
#* mean multiple parameters: 'Splat operator'
  def initialize(*args)
    if args.length == 1 && args[0].class == Array
      @args = args.first
    else
      @args = args
    end

    post_init(args)
  end

  def post_init(args)
  end

  def ==(exp)
    exp.class == self.class && args == exp.args
  end

  def copy
    DeepClone.clone self
  end
end
