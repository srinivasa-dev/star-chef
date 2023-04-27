import 'package:http/http.dart';

class StarChefService {

  String baseUrl = 'https://8b648f3c-b624-4ceb-9e7b-8028b7df0ad0.mock.pstmn.io/dishes/v1/';

  Future<Response> getAllDetails() async {
    final response = await get(Uri.parse(baseUrl),);

    return response;
  }

  Future<Response> getIngredients() async {
    final response = await get(Uri.parse('${baseUrl}1'),);

    return response;
  }

}