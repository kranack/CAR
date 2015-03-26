import Pyro4

Pyro4.config.REQUIRE_EXPOSE = True

class SiteRMI:

    def __init__(self, id):
        self.value = id
        self.launchDaemon()

    def launchDaemon(self):
        self._daemon = Pyro4.Daemon()

    def register(self):
        self._uri = self._daemon.register(self)
        ns = Pyro4.locateNS()
        ns.register("site.{0}".format(self.value), self._uri)

    @Pyro4.expose
    def get_value(self):
        return self.value
