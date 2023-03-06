enum Host {
  google,
  undefined,
}

extension HostExtension on Host {
  get url {
    switch (this) {
      case Host.google:
        return 'www.googleapis.com';
      case Host.undefined:
        return '';
    }
  }
}
