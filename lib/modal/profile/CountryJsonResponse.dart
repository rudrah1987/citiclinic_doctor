class CountryJsonResponse {
  List<String> countryNames;

  CountryJsonResponse(this.countryNames);

  CountryJsonResponse.fromJson(Map<String, dynamic> json){
    countryNames = List<String>();
    // ignore: unnecessary_statements
    (json.forEach((key, value) {
      countryNames.add(key);
    }) as List);
  }
}