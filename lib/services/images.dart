
import 'package:dio/dio.dart';

class ImageServices{

   static Future<Map> sendImage(String filePath) async {

    var dio = Dio();
    FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile( filePath , filename: "image"),
    });
    print("Enviando petición...");
    final response = await dio.post("http://192.168.0.102:8080/api/cbir/", data: formData);
    return response.data;

  }
}

