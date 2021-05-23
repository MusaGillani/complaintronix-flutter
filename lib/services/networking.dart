import 'package:http/http.dart' as http;
import 'dart:convert';

class Networking {
  final _url = 'complaintronix.herokuapp.com';
  String _api = '/api/';

  Future<int> checkhostelHeads({String email}) async {
    print('email provided' + email);
    _api += 'heads';
    http.Response res = await http.get(
      Uri.https(_url, _api, {
        'email': email,
      }),
    );
    // print(res.body);
    dynamic result = jsonDecode(res.body);
    // print(result[0]['hostel_no']);
    return res.body == 'false' ? 0 : result[0]['hostel_no'] ?? null;
  }
}
