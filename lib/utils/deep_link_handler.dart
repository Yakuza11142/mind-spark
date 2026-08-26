class DeepLinkHandler {
  static String? parseRoute(String link) {
    if (link.contains('pro_unlock')) return '/pro_checkout';
    return null;
  }
}
