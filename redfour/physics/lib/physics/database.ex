# See ch 13
#
# use Amnesia
#
# # Macro for adding a database
# defdatabase Physics.Database do
#
#   # One of many Macros for defining a schema.
#   # There are three table types:
#   #  `bag` - unorganized data
#   #  `set` - each record has a unique key
#   #  `ordered_set` - like `set`, but sorted by key
#   deftable Planet, [{:id, autoincrement }, :name, :mass, :radius, :type, :ev], type: :ordered_set do
#     #helper methods, lookups, special queries etc can go in here
#     #for instance:
#     #def add_moon(self, moon) do
#       # add to moons table
#     #end
#   end
#
# end
