require './models/expressions/expression'
require './models/expressions/addition'
require './models/expressions/multiplication'
require './models/expressions/division'
require './models/expressions/power'


require './models/objectifiers/objectify_superclass'
require './models/objectifiers/addition'
require './models/objectifiers/multiplication'
require './models/objectifiers/division'
require './models/simplifier'
require './models/between_brackets'


require './lib/factory'
require './lib/state_checker'
include Factory
include StateChecker


# require './lib/string'
require './lib/state_checker'
require './lib/string'
