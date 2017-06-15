require './models/expression_super_classes/expression'
require './models/addition'
require './models/multiplication'
require './models/division'
require './models/power'


require './models/objectifiers/objectify_superclass'
require './models/objectifiers/addition'
require './models/objectifiers/multiplication'
require './models/objectifiers/division'


require './lib/factory'
require './lib/state_checker'
include Factory
include StateChecker
require './lib/simplifier'
require './lib/between_brackets'


# require './lib/string'
require './lib/state_checker'
require './lib/math_regexes'
require './lib/string_final'


#FOR TESTING MAKE SURE TO REMOVE!
require 'pry'
