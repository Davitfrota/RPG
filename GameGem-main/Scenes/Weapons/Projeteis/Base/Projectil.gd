extends Resource

class_name Projectil

export(float) var scaleX = 1;
export(float) var scaleY = 1;
export(int) var collisionRadius = 10;
export(Texture) var staticTexture = null;
export(Texture) var lightTexture = null;
export(bool) var subdivide = false;
export var speed = 500;
export var ricochetes = 0;
