class NetworkConstants {
  const NetworkConstants._();

  static const String jsonplaceholderBaseUrl =
      'https://jsonplaceholder.typicode.com';

  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const int maxRetryAttempts = 1;
}
