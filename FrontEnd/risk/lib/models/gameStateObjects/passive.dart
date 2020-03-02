class Passive {
  int cost;
  int duration;
  bool active;
  int passiveValue;
  PassiveModifiers modifiedValue;
}

enum PassiveModifiers { defense, attack, troopGeneration, moneyGeneration }
