def split_string(string, separator=' '):
    if separator == '':
      return list(string)
    else:
      return string.split(separator)

class FilterModule(object):
    def filters(self):
        return {'split' : split_string }
