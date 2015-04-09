import threading
import Pyro4

Pyro4.config.REQUIRE_EXPOSE = True

class SiteRMI:

    pere = None
    fils = []

    def __init__(self, id, pere = None):
        self.value = id
        self.pere = pere
        self.launchDaemon()

    def launchDaemon(self):
        self._daemon = Pyro4.Daemon()

    def enterLoop(self):
        self._loop_thread = threading.Thread(target=self._daemon.requestLoop)
        self._loop_thread.start()

    def register(self):
        self._uri = self._daemon.register(self)
        ns = Pyro4.locateNS()
        ns.register("site.{0}".format(self.value), self._uri)

    @Pyro4.expose
    def get_value(self):
        return self.value

    @Pyro4.expose
    def add_fils(self, site):
        if not site in self.fils:
            self.fils.append(site)

    @Pyro4.expose
    def get_fils(self):
        return self.fils
