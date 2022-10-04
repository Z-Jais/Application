import 'package:jais/entities/country.dart';
import 'package:jais/mappers/jmapper.dart';
import 'package:jais/url/url_const.dart';

class CountryMapper extends JMapper<Country> {
  static final CountryMapper instance = CountryMapper();
  static Country? selectedCountry;

  CountryMapper() : super(url: UrlConst.countries, fromJson: Country.fromJson);

  @override
  Future<void> update() async {
    await super.update();
    // Set the selected country to the first one in the list
    selectedCountry = list.first;
  }
}
