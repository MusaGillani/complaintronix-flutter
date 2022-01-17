import 'package:http/http.dart' as http;
import 'dart:convert';

// final _url = '127.0.0.1:5000';
final _url = 'complaintronix.herokuapp.com';

// Student api used here

Future registerWithEmail({
  String email,
  String password,
  String reg,
  String hostel,
  String room,
  String name,
}) async {
  String _api = '/api/students';
  http.Response res = await http.post(
    Uri.parse('https://$_url$_api'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      'email': email,
      'password': password,
      'reg_no': int.parse(reg),
      'name': name,
      'hostel_no': hostel,
      'room_no': room,
    }),
  );
  return res.body;
}

Future signInWithEmail({String email, String password}) async {
  String _api = '/api/students';
  http.Response res = await http.get(
    Uri.https(_url, _api, {
      'email': email,
      'password': password,
    }),
  );
  return res.body;
}

// Hostel head API used here

Future<String> checkhostelHeads({String reg, String hostel}) async {
  String _api = '/api/heads';
  http.Response res = await http.get(
    Uri.https(_url, _api, {
      'reg_no': reg,
      'hostel_no': hostel,
    }),
  );
  // print(res.body);
  // dynamic result = jsonDecode(res.body);
  // print(result[0]['hostel_no']);
  // return res.body == 'false'
  //     ? 0
  //     : result[0]['hostel_no'] ??
  //         null; // explicitly returning null if result is null
  return res.body;
}

// Complaints API used here
Future<List<Map<String, String>>> getHostelComplaints(
    {int hostelNumber}) async {
  print('hostel number:  $hostelNumber');
  String _api = '/api/complaints';
  http.Response res = await http.get(
    Uri.https(_url, _api, {
      'hostel_no': "$hostelNumber",
    }),
  );

  dynamic result = jsonDecode(res.body);
  List<Map<String, String>> data = [];
  if (result.length != 0) {
    print(result);
    // print(res['student_name']);
    // print(res['room_no']);
    // print(res['type']);

    for (var res in result['rows'])
      data.add({
        'reg': res['complaintee_reg'].toString(),
        'room': res['room_no'].toString(),
        'issue': res['complaint_type'],
        'isChecked': res['complaint_status'] == 'unassigned' ? 'false' : 'true',
      });
  } else {
    print('no complaints');
    // return empty list , size zero
  }

  return data;
}

Future<int> registerComplaint({String email, String desc, String type}) async {
  String _api = '/api/complaints';
  final response = await http.post(
    Uri.parse('https://$_url$_api'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': email,
      'complaint_desc': desc,
      'complaint_type': type
    }),
  );
  print('email ' + email);
  print('complaint_desc ' + desc);
  print('complaint_type ' + type);

  if (response.statusCode == 200) {
    // dynamic data = jsonDecode(response.body);
    print('printing post response\n');
    print(response.body);
  } else {
    print('Failed to register complaint.');
  }
  return response.statusCode;
}

Future updateComplaint({String reg, String status}) async {
  String _api = '/api/complaints';
  final res = await http.put(
    Uri.parse('https://$_url$_api'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{'reg_no': '$reg', 'status': '$status'}),
  );

  if (res.statusCode == 200) {
    dynamic data = jsonDecode(res.body);
    print(data);
  } else {
    print('Failed to update complaint.');
  }
}

Future<int> deleteComplaint({int reg}) async {
  String _api = '/api/complaints';
  final http.Response response = await http.delete(
    Uri.parse('https://$_url$_api'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, int>{
      'reg_no': reg,
    }),
  );

  if (response.statusCode == 200) {
    dynamic data = jsonDecode(response.body);
    print(data);
  } else {
    print('Failed to delete complaint.');
  }
  print(response.statusCode);
  print(response.body);
  return response.statusCode;
}

Future<dynamic> getComplaintStatus({String email}) async {
  String _api = '/api/complaints/status';
  final http.Response response = await http.get(
    Uri.https(_url, _api, {
      'email': '$email',
    }),
  );
  dynamic res = 'empty';
  if (response.statusCode == 200) {
    print(response.body);
  } else {
    print('error in api call');
  }
  print(res);
  if (response.body != 'empty') res = jsonDecode(response.body);

  return res;
}
