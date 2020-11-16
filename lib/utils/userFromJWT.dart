import 'dart:convert';

String getUserIdFromToken(token) {
  final tokenParts = token.split('.');
  if (tokenParts.length != 3) {
    throw Exception('Invalid Token');
  }
  final payload = decodeBase64(tokenParts[1]);
  final payloadMap = json.decode(payload);
  return (payloadMap["_id"]);
}

String decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');
  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}
