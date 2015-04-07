import SiteRMI
import Pyro4

ns = Pyro4.locateNS()

site0 = ns.lookup("site.0")
site1 = ns.lookup("site.1")
site2 = ns.lookup("site.2")
site3 = ns.lookup("site.3")
site4 = ns.lookup("site.4")
site5 = ns.lookup("site.5")

print "site0: {0}".format(site0)
print "site1: {0}".format(site1)

proxy = Pyro4.Proxy(site0)
proxy.add_fils(site1)
proxy.add_fils(site4)
proxy = Pyro4.Proxy(site1)
proxy.add_fils(site2)
proxy.add_fils(site3)
proxy = Pyro4.Proxy(site4)
proxy.add_fils(site5)
