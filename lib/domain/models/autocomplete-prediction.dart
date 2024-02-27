class AutoCompletePrediction {
  /// [description] contains the human-readable name for thereturned result...

  final String? description;

  /// [structuredFormatting] provides pre-formatted texts
  final StructuredFormatting? structuredFormatting;

  /// [placeId] the id of the place
  final String? placeId;

  /// [reference] contains reference
  final String? reference;

  const AutoCompletePrediction(
      {this.description,
      this.structuredFormatting,
      this.placeId,
      this.reference});

  factory AutoCompletePrediction.fromJson({required final Map json}) {
    return AutoCompletePrediction(
      description: json['description'] as String?,
      reference: json['reference'] as String?,
      placeId: json['place_id'] as String?,
      structuredFormatting: json['structured_formatting'] != null?StructuredFormatting.fromJson(json: json['structured_formatting']) :null
    );
  }
}

class StructuredFormatting {
  /// [mainText] contains the main text of the predictions
  final String? mainText;

  /// [secondaryText] contains secondary text of predictions
  final String? secondaryText;
  const StructuredFormatting({this.mainText,this.secondaryText});

  factory StructuredFormatting.fromJson({required Map<String, dynamic> json}){
    return StructuredFormatting(
      mainText: json['main_text'] as String?, 
      secondaryText: json['secondary_text'] as String?);
  }
}
