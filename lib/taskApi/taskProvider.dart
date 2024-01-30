import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:tasks/taskApi/taskDataModel.dart';

class DataProvider extends ChangeNotifier {
  List<Datum> _data = [];

  List<Datum> get data => _data;

  Future<void> fetchData() async {
    final response = await http.post(
      Uri.parse("https://app.batic2024.com/api/attendees"),
      body: jsonEncode({"event_id": 2}),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonData = json.decode(response.body);
      print("API Response: $jsonData");
      final taskData = TaskDataModel.fromJson(jsonData);
      _data = taskData.data;
      notifyListeners();
    } else {
      throw Exception('Failed to load data');
    }
  }
}
