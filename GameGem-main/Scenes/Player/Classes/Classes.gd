extends Resource

class_name Class

enum ClassTypes {NOCLASS, WARRIOR, MAGE, NECROMANCER}

export(ClassTypes) var classType;
export(Resource) var defaultWeapon;
export(int) var strengthValue = 0; 
export(int) var enduranceValue = 0; 
export(int) var staminaValue = 0; 
export(int) var intelligenceValue = 0; 
export(int) var luckValue = 0; 

func increaseEndurance(value):
	enduranceValue += value;

func increaseLuck(value):
	luckValue += value;

func increaseStrength(value):
	strengthValue += value;

func increaseStamina(value):
	staminaValue += value;

func increaseIntelligence(value):
	intelligenceValue += value;
