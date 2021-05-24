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
  if (result.length != 0) {
    print(result);
    print(result[0]['student_name']);
    print(result[0]['room_no']);
    print(result[0]['type']);
  } else { 
    print('no complaints');
  }

  return result ?? null ; // explicitly returning null if result is null
}


Future registerComplaint({int reg_no,String name,String email,int hostel_no,int room_no,String phone,String type}) async {
  final response = await http.post(
    Uri.parse('https://complaintronix.herokuapp.com/api/complaints'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'reg_no':reg_no.toString(),
      'student_name':name,
      'email': email,
     'hostel_no': hostel_no.toString(),
     'room_no':room_no.toString(),
     'phone_no':phone,
     'type':type}),
  );

  if (response.statusCode == 200) {
    dynamic data = jsonDecode(response.body);
    print(data);
  } else {
    throw Exception('Failed to register complaint.');
  }
}
