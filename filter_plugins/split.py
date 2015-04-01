def split_string(string, separator=' '):
    return string.split(separator)

class FilterModule(object):
    def filters(self):
        return {'split' : split_string }
