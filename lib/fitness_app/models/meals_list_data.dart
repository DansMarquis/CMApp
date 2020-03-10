class MealsListData {
  MealsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.meals,
    this.kacl = 0,
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String> meals;
  int kacl;

  static List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      imagePath: 'assets/fitness_app/breakfast.png',
      titleTxt: 'Misty Montains',
      kacl: 0,
      meals: <String>['45', '1243', '32', '15 Mar 18:45'],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/lunch.png',
      titleTxt: 'Crick Valley',
      kacl: 0,
      meals: <String>['67', '2056', '26', '02 Apr 8:43'],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/snack.png',
      titleTxt: 'Rose Trails',
      kacl: 0,
      meals: <String>['32', '1056', '16', '11 Dec 7:05'],
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/dinner.png',
      titleTxt: 'River Jack',
      kacl: 0,
      meals: <String>['59', '1740', '31', '30 Jan 21:12'],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
}
