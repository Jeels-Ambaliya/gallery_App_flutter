import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../Modal/api_Modal.dart';

class Api_Helper {
  Api_Helper._();

  static final Api_Helper api_helper = Api_Helper._();

  getImage({required String category}) async {
    http.Response response = await http.get(
      Uri.parse(
        "https://pixabay.com/api/?key=35722369-0ff268194d7105d16de321576&q=$category&image_type=photo&pretty=true",
      ),
    );

    if (response.statusCode == 200) {
      dynamic decodedData = jsonDecode(response.body);
      List imageList = decodedData['hits'];
      List<ApiModal> data = imageList
          .map(
            (e) => ApiModal.fromMaptoImageObject(data: e),
          )
          .toList();
      return data;
    }
  }
}
