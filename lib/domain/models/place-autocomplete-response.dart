// ignore_for_file: prefer_null_aware_operators

import 'dart:convert';

import 'autocomplete-prediction.dart';

class PlaceAutoCompleteResponse {
  final String? status;
  final List<AutoCompletePrediction>? predictions;

  const PlaceAutoCompleteResponse(
      {required this.status, required this.predictions});

  factory PlaceAutoCompleteResponse.fromJson(
      {required Map<String, dynamic> json}) {
    return PlaceAutoCompleteResponse(
        status: json['status'] as String?,
        predictions: json['predictions'] != null
            ? json['predictions']
                .map<AutoCompletePrediction>(
                    (json) => AutoCompletePrediction.fromJson(json: json))
                .toList()
            : null);
  }

  static PlaceAutoCompleteResponse parseAutoCompleteResult(
      String responseBody) {
    final json = jsonDecode(responseBody) as Map<String, dynamic>;
    return PlaceAutoCompleteResponse.fromJson(json: json);
  }
}
