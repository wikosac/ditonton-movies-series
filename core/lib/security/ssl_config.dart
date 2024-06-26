import 'dart:io';

import 'package:flutter/services.dart';

Future<HttpClient> getHttpClient() async {
  final sslCert = await rootBundle.load('certificate/certificate.pem');
  SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
  securityContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());

  HttpClient client = HttpClient(context: securityContext);
  client.badCertificateCallback =
      (X509Certificate cert, String host, int port) => false;

  return client;
}
