class GamificationService {
  int calculateSparksEarned({required bool isCorrect, required int streakCount, required int timeTakenSeconds}) {
    if (!isCorrect) return 2;
    int baseSparks = 10;
    int streakBonus = streakCount * 2;
    int speedBonus = timeTakenSeconds < 5 ? 5 : 0;
    return baseSparks + streakBonus + speedBonus;
  }
}
