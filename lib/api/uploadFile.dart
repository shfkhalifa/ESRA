import 'dart:io';
import 'dart:async';

import 'package:http/http.dart' as http;

Future<bool> uploadFile(String url, File image) async {
  try {
    UploadFile uploadFile = UploadFile();
    await uploadFile.call(url, image);

    if (uploadFile.isUploaded != null && uploadFile.isUploaded) {
      return true;
    } else {
      throw uploadFile.message;
    }
  } catch (e) {
    throw e;
  }
}

class UploadFile {
  bool success;
  String message;

  bool isUploaded;

  Future<void> call(String url, File image) async {
    try {
      var response = await http.put(url, body: image.readAsBytesSync());
      if (response.statusCode == 200) {
        isUploaded = true;
      }
    } catch (e) {
      throw ('Error uploading photo');
    }
  }
}
