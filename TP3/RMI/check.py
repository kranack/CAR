import SiteRMI
import Pyro4

ns = Pyro4.locateNS()

sites = ns.list("site")


for name, site in sites.iteritems():
    proxy = Pyro4.Proxy(site)
    id = proxy.get_id()
    value = proxy.get_value()
    fils = proxy.get_fils()
    print "server #{0}: value => {1}; fils => {2}".format(id, value, fils)
