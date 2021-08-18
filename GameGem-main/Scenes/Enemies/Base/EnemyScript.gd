extends Resource

class_name EnemyType

enum EnemyFamily {UNDEAD, DEMON, FOREST, HUMAN}
enum EnemyUndeadTypes {NULL, ZOMBIE, SKELETON}
enum EnemyDemonTypes {NULL, DEMON}
enum EnemyForestTypes {NULL, GOLEM, GOBLIN}
enum EnemyHumanTypes {NULL, KNIGHT, MAGE, ARCHER, OTHER}

export(String) var enemyName;
export(EnemyFamily) var enemyFamily;
export(EnemyUndeadTypes) var enemyUndeadType;
export(EnemyDemonTypes) var enemyDemonType;
export(EnemyForestTypes) var enemyForestType;
export(EnemyHumanTypes) var enemyHumanType;

export(int) var strengthValue = 0; 
export(int) var enduranceValue = 0; 
export(int) var staminaValue = 0; 
export(int) var intelligenceValue = 0;
export(int) var summonManaCost = 100;
