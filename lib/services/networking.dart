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


Future registerComplaint({int reg,String name,String email,int hostel,int room,String phone,String type}) async {
  final response = await http.post(
    Uri.parse('https://complaintronix.herokuapp.com/api/complaints'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'reg_no':reg.toString(),
      'student_name':name,
      'email': email,
     'hostel_no': hostel.toString(),
     'room_no':room.toString(),
     'phone_no':phone,
     'type':type}),
  );

  if (response.statusCode == 200) {
    dynamic data = jsonDecode(response.body);
    print(data);
  } else {
    print('Failed to register complaint.');
  }
}


Future updateComplaint({int id}) async {
  final res = await http.put(
    Uri.parse('https://complaintronix.herokuapp.com/api/complaints'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'id': '$id',
    }),
  );

  if (res.statusCode == 200) {
    dynamic data = jsonDecode(res.body);
    print(data);
  } else {
    throw Exception('Failed to update complaint.');
  }
}
