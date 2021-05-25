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
  return res.body == 'false'
      ? 0
      : result[0]['hostel_no'] ??
          null; // explicitly returning null if result is null
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

    for (var res in result)
      data.add({
        'reg': res['reg_no'].toString(),
        'room': res['room_no'],
        'issue': res['type'],
        'isChecked': res['status'] == 'pending' ? 'false' : 'true',
      });
  } else {
    print('no complaints');
    // return empty list , size zero
  }

  return data;
}

Future<int> registerComplaint(
    {String reg,
    String name,
    String email,
    int hostel,
    String room,
    String phone,
    String type}) async {
  final response = await http.post(
    Uri.parse('https://complaintronix.herokuapp.com/api/complaints'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'reg_no': '$reg',
      'student_name': name,
      'email': email,
      'hostel_no': hostel.toString(),
      'room_no': '$room',
      'phone_no': phone,
      'type': type
    }),
  );

  // if (response.statusCode == 200) {
  //   dynamic data = jsonDecode(response.body);
  //   print('printing post response\n');
  //   print(data);
  // } else {
  //   print('Failed to register complaint.');
  // }
  return response.statusCode;
}

Future updateComplaint({String reg, String status}) async {
  final res = await http.put(
    Uri.parse('https://complaintronix.herokuapp.com/api/complaints'),
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

Future deleteComplaint({int id}) async {
  final http.Response response = await http.delete(
    Uri.parse('https://complaintronix.herokuapp.com/api/complaints'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'id': '$id',
    }),
  );

  if (response.statusCode == 200) {
    dynamic data = jsonDecode(response.body);
    print(data);
  } else {
    throw Exception('Failed to delete complaint.');
  }
}
