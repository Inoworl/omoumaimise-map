enum AppEnvironment {
  local,
  dev,
  prod;

  static AppEnvironment fromName(String? name) {
    switch (name) {
      case 'local':
        return AppEnvironment.local;
      case 'prod':
        return AppEnvironment.prod;
      case 'dev':
      case '':
      case null:
        return AppEnvironment.dev;
      default:
        throw ArgumentError.value(name, 'name', 'Unsupported app environment');
    }
  }

  bool get isLocal => this == AppEnvironment.local;
  bool get isDev => this == AppEnvironment.dev;
  bool get isProd => this == AppEnvironment.prod;
}
