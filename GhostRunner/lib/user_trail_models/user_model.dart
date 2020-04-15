class User {
  int userID;
  String userName;
  String userWeight;
  String userHeight;
  String userGoal;
  List<int> mytrailsID;
  List<int> trailsPerformed;
  String img;

  User(
      {this.userID,
      this.userName,
      this.userWeight,
      this.userHeight,
      this.userGoal,
      this.mytrailsID,
      this.trailsPerformed,
      this.img});
}

final List<User> users = [
  User(
      userID: 0,
      userName: 'Daniel Marques',
      userWeight: '85',
      userHeight: '1.84',
      userGoal: '500',
      mytrailsID: [0],
      trailsPerformed: [4],
      img: 'user0.png'),
  User(
      userID: 1,
      userName: 'Miguel Dinis',
      userWeight: '74',
      userHeight: '1.76',
      userGoal: '550',
      mytrailsID: [2],
      trailsPerformed: [0,1],
      img: 'user1.png'),
  User(
      userID: 2,
      userName: 'Patrícia Mamona',
      userWeight: '61',
      userHeight: '166',
      userGoal: '500',
      mytrailsID: [3],
      trailsPerformed: [2, 4],
      img: 'user2.png'),
  User(
      userID: 3,
      userName: 'Cristiano Ronaldo',
      userWeight: '85',
      userHeight: '187',
      userGoal: '492',
      mytrailsID: [4],
      trailsPerformed: [0, 3],
      img: 'user3.png'),
  User(
      userID: 4,
      userName: 'Teresa Portela',
      userWeight: '63',
      userHeight: '163',
      userGoal: '610',
      mytrailsID: [],
      trailsPerformed: [2],
      img: 'user4.png'),
  User(
      userID: 5,
      userName: 'Marcos Freitas',
      userWeight: '75',
      userHeight: '1.82',
      userGoal: '360',
      mytrailsID: [],
      trailsPerformed: [1, 4],
      img: 'user5.png'),
  User(
      userID: 6,
      userName: 'João Félix',
      userWeight: '70',
      userHeight: '181',
      userGoal: '456',
      mytrailsID: [],
      trailsPerformed: [0, 1, 3],
      img: 'user6.png'),
];
