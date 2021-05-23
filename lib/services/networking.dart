import 'package:http/http.dart' as http;
import 'dart:convert';

final _url = 'complaintronix.herokuapp.com';


// Hostel head API used here
Future<int> checkhostelHeads({String email}) async {
  String _api = '/api/heads';
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

// Complaints API used here
Future getHostelComplaints({int hostelNumber}) async {
  print('hostel number:  $hostelNumber');
  String _api = '/api/complaints';
  http.Response res = await http.get(
    Uri.https(_url, _api, {
      'hostel_no': "$hostelNumber",
    }),
  );

  dynamic result = jsonDecode(res.body);
  print(result);
  print(result[0]['student_name']);
  print(result[0]['room_no']);
  print(result[0]['type']);
  // return result ?? null ; // explicitly returning null if result is null
}
