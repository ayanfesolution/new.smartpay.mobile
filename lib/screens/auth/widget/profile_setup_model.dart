

class CountryListModel {
  final String counrtyName, countryAbbrevtion, imagePath;

  CountryListModel(
    this.counrtyName,
    this.countryAbbrevtion,
    this.imagePath,
  );
}

final List<CountryListModel> listOfAllUsedCountries = [
  CountryListModel(
    'United States',
    'US',
    'assets/svgs/usa.svg',
  ),
  CountryListModel(
    'United Kingdom',
    'GB',
    'assets/svgs/uk.svg',
  ),
  CountryListModel(
    'Singapore',
    'SO',
    'assets/svgs/singapor.svg',
  ),
  CountryListModel(
    'China',
    'CN',
    'assets/svgs/China.svg',
  ),
  CountryListModel(
    'Netherland',
    'NL',
    'assets/svgs/Netherlands.svg',
  ),
  CountryListModel(
    'Indonesia',
    'ID',
    'assets/svgs/indonasia.svg',
  ),
];
