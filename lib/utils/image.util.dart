import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageUtil {
  static Future<XFile?> getImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: source);
    return image;
  }

  static Future<UploadTask> upload(String path, String ref) async {
    File file = File(path);
    try {
      return FirebaseStorage.instance.ref(ref).putFile(file);
    } on FirebaseException catch (error) {
      throw Exception('Erro no upload ${error.code}');
    }
  }
}
