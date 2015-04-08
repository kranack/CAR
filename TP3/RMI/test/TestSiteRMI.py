import unittest
import Pyro4

import sys
sys.path.insert(0, '..')
import SiteRMI

class TestCreateRMI(unittest.TestCase):

    def test_create(self):
        site = SiteRMI.SiteRMI(1)
        site.register()
        self.assertEqual(site.get_id(), 1)

    def test_lookup(self):
        site = SiteRMI.SiteRMI(1)
        site.register()
        ns = Pyro4.locateNS()
        self.assertTrue(ns.lookup("site.1"))

if __name__ == '__main__':
    unittest.main()
