
class SystemBus:
    pass

    def get_object(self, uri, path):
        return None


class SessionBus:
    pass

    def get_object(self, uri, path):
        return None


class Interface:
    def __init__(self, obj, uri):
        pass

    def connect_to_signal(self, name, callback):
        pass

    def ServiceBrowserNew(self, interface, protocol, service, domain, flags):
        return None
