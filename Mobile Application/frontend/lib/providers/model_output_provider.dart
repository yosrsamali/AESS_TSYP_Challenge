import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/model_output.dart';

class ModelOutputProvider with ChangeNotifier {
  ModelOutput? _modelOutput;

  ModelOutput? get modelOutput => _modelOutput;

  Future<void> fetchModelOutput() async {
    final response = await http.get(
      Uri.parse('http://localhost:5000/api/model-output'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      _modelOutput = ModelOutput.fromJson(data);
      notifyListeners();
    } else {
      throw Exception('Failed to fetch model output');
    }
  }
}
