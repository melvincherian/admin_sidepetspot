
// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class CloudinaryService {
  static const String cloudName = 'do9dkxsc0';
  static const String uploadPreset = 'qxl49pfm';
  static const String apiKey = '716346215499246';
  static const String apiSecret = '-SKpyiXJuNtwqxvOidQf7eLAvms';

  static Future<String?> uploadImage(File imageFile) async {
    try {
      final uri = Uri.parse('https://api.cloudinary.com/v1_1/do9dkxsc0/image/upload');
      
      final request = http.MultipartRequest('POST', uri)
        ..fields['upload_preset'] = 'qxl49pfm' // If using unsigned preset
        ..fields['api_key'] = '716346215499246' // If needed for signed uploads
        ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final decodedData = jsonDecode(responseData);
        return decodedData['secure_url']; // Returns the uploaded image URL
      } else {
        print('Image upload failed with status: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }
}



