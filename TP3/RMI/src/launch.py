import SiteRMI
import Pyro4

sites = {}

for i in range(10):
    sites[i] = SiteRMI.SiteRMI(i)
    sites[i].register()
    sites[i].enterLoop()

'''
Pyro4.Daemon.serveSimple(
        {
            site: None
        },
        host = '127.0.0.1',
        ns = True)
'''
