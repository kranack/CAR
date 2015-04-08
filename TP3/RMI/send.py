import SiteRMI
import Pyro4

ns = Pyro4.locateNS()

site0 = ns.lookup("site.0")
proxy = Pyro4.Proxy(site0)
proxy.send(1)
