import unittest
import threading
import Pyro4

class TestNameServer(unittest.TestCase):

    def test_create(self):
        nameserverUri, nameserverDaemon, broadcastServer = Pyro4.naming.startNS()
        self.assertTrue(Pyro4.locateNS())






if __name__ == '__main__':
    unittest.main()
