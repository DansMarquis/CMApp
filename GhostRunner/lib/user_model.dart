
class User {
  int userID;
  String userName;
  String userWeight;
  String userHeight;
  String userGoal;
  List<int> mytrailsID;
  List<int> trailsPerformed;

  User(
      {this.userID,
      this.userName,
      this.userWeight,
      this.userHeight,
      this.userGoal,
      this.mytrailsID,
      this.trailsPerformed});
}

final List<User> trails = [
  User(
    userID: 0,
    userName: 'Daniel Marques',
    userWeight: '85',
    userHeight: '1.84',
    userGoal: '500',
    mytrailsID: [0,1],
    trailsPerformed: [0,1,2]
  ),
   User(
    userID: 2,
    userName: 'Miguel Dinis',
    userWeight: '74',
    userHeight: '1.76',
    userGoal: '550',
    mytrailsID: [2],
    trailsPerformed: [1,]
  ),
   User(
    userID: 3,
    userName: 'Benjamin Bratton',
    userWeight: '90',
    userHeight: '1.75',
    userGoal: '500',
    mytrailsID: [3],
    trailsPerformed: [3,4]
  ),
   User(
    userID: 4,
    userName: 'Jon Normile',
    userWeight: '70',
    userHeight: '1.75',
    userGoal: '492',
    mytrailsID: [4],
    trailsPerformed: [0,3]
  ),
   User(
    userID: 5,
    userName: 'Maya Lawrence',
    userWeight: '64',
    userHeight: '1.63',
    userGoal: '610',
    mytrailsID: [],
    trailsPerformed: [2]
  ),
   User(
    userID: 6,
    userName: 'Arlene Stevens',
    userWeight: '69',
    userHeight: '1.60',
    userGoal: '360',
    mytrailsID: [],
    trailsPerformed: [1,4]
  ),
   User(
    userID: 7,
    userName: 'Michael Marx',
    userWeight: '85',
    userHeight: '1.68',
    userGoal: '456',
    mytrailsID: [],
    trailsPerformed: [0,1,3]
  ),
];
