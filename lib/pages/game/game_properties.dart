class GameProperties {
  String difficulty = 'easy';
  String category = '';
  late int noOfQuestions;
  late int timeLimit;

  GameProperties(
    this.difficulty,
    this.category, {
    this.noOfQuestions = 10,
    this.timeLimit = 15,
  });
}
