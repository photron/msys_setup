

CLIENT_PRELOAD_NONE = 1

VALUE_STRING = 2


class Value:
    def get_int(self):
        return 1

class Client:
    def add_dir(self, dir, flags):
        pass

    def all_dirs(self, key):
        return []

    def notify_add(self, path, callback, userdata=None):
        pass

    def get(self, path):
        return Value()

    def get_bool(self, path):
        if path.endswith("/system-tray"):
            return False
        else:
            return False

    def set_bool(self, path, value):
        pass

    def get_int(self, path):
        if path.endswith("/stats/update-interval"):
            return 5
        else:
            return 1

    def set_int(self, path, value):
        pass

    def get_string(self, path):
        return ""

    def set_string(self, path, value):
        pass

    def get_list(self, path, item_type):
        if path.endswith("/connections/uris"):
            return ["qemu+tls://sbox/system"]
        else:
            return None

    def set_list(self, path, item_type, value):
        pass

    def recursive_unset(self, key, value):
        pass

    def suggest_sync(self):
        pass


def client_get_default():
    return Client()


def escape_key(uri, uri_len):
    return uri
