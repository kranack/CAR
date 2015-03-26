# This is the code that visits the warehouse.
import sys
import Pyro4
from person import Person

sys.execpthook = Pyro4.util.excepthook

warehouse = Pyro4.Proxy("PYRO:example.warehouse@localhost:40754")
janet = Person("Janet")
henry = Person("Henry")
janet.visit(warehouse)
henry.visit(warehouse)
