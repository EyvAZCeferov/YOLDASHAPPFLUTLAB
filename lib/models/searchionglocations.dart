class SearchingLocations {
  final String? secondary_text;
  final String? main_text;
  final String? place_id;

  SearchingLocations({
    this.secondary_text,
    this.main_text,
    this.place_id,
  });

  factory SearchingLocations.fromJson(Map<String, dynamic> json) {
    return SearchingLocations(
      place_id: json['place_id'],
      main_text: json['structured_formatting']['main_text'],
      secondary_text: json['structured_formatting']['secondary_text'],
    );
  }
}
