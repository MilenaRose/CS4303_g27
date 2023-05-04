public class Player {
    PVector position = new PVector(0, 0);
    float width;
    float height;
    int health;
    int max_health;
    int max_attack;
    int max_defense ;
    int attack;
    int defense;
    int xp;
    PVector initialPosition = new PVector(0, 0);
    PVector velocity = new PVector(0, 0);

    ArrayList<String> equipped = new ArrayList<String>();
    ArrayList<String> inventory = new ArrayList<String>();
    ArrayList<Integer> inventoryCount = new ArrayList<Integer>();
    
    
    Player(float x, float y, float width, float height) {
        this.position.x = x;
        this.position.y = y;
        this.initialPosition.x = x;
        this.initialPosition.y = y;
        this.width = width;
        this.height = height;
        max_health = 20;
        max_attack = 10;
        max_defense = 10;
        health = max_health;
        attack = 2;
        defense = 10;
        xp = 0;

        gotItem("Health Potion");
        gotItem("Health Potion");
        gotItem("Health Potion");
        gotItem("Armour");
        gotItem("Ring");
        
    }
    
    public void moveLeft() {
        this.velocity.x += -8;
    }
    
    public void moveRight() {
        this.velocity.x += 8;
    }
    
    public void moveUp() {
        this.velocity.y += -8;
    }
    
    public void moveDown() {
        this.velocity.y += 8;
    }
    
    public void stop() {
        this.velocity.mult(0);
    }
    
    public void updatePlayer() {
        this.position.add(this.velocity);
        velocity.mult(0);
        if(xp >= 20) {
            attack += 2;
            defense += 2;
            max_health += 5;
            health = max_health;
            xp = xp - 20;
        }
    }
    
    public void displayPlayer() {
        fill(255);
        strokeWeight(0);
        rect(this.position.x, this.position.y, this.width, this.height);
    }
    
    public void inventoryDisplay() {
        
        textSize(128);
        text("Inventory", 40, 120);
        textSize(50);
        fill(0, 408, 612);
        text("Health : " + health, 40, 240);
        fill(0, 408, 612, 204);
        text("Attack : " + attack, 390, 240);
        fill(0, 408, 612, 102);
        text("Defense : " + defense, 640, 240);
        fill(0);
        text("XP : " + xp, 990, 240);
        //inventory
        for (int i = 0;  i < inventory.size(); i++) {
            fill(0);
            text(inventory.get(i) + "   X " + inventoryCount.get(i) , 40, 360 + (i * 120));
            fill(255);
            rect(740,360 + (i * 120), 50, 30);
            textSize(30);
            fill(0);
            text("use", 740,380 + (i * 120));
        }
        //equipped
        textSize(30);
        fill(0, 150, 250);
        text("Equipped -", 1300, 240);
        for(int i = 0; i < equipped.size(); i++) {
            fill(0);
            text(equipped.get(i), 1300, 360 + (i * 80));
        }
    }

    public void teleport(PVector pos) {
        this.position = pos;
    }
    
    public void gotItem(String item) {
        if (!inventory.contains(item)) {
            inventory.add(item);
            inventoryCount.add(1);
        } else {
            int index = inventory.indexOf(item);
            inventoryCount.set(index, inventoryCount.get(index) + 1);
        }

    }
    
    public void useItem(int index) {
            boolean used = false;

            System.out.println(inventory.get(index));
            System.out.println(index);
            if(inventory.get(index).equals("Health Potion")) {
                if(health != max_health) {
                    health += 2;
                    used = true;
                    if(health > max_health) {
                        health = max_health;
                    }
                }
            } else if(inventory.get(index).equals("Attack Potion")) {
                if(attack!= max_attack) {
                attack += 1;
                used = true;
                if(attack > max_attack) {
                    attack = max_attack;
                }
                }
            } else if(inventory.get(index).equals("Defense Potion")) {
                if(defense != max_defense) {
                defense += 1;
                used = true;
                if(defense > max_defense) {
                    defense = max_defense;
                }

            } 
            } else if(inventory.get(index).equals("Sword")) {
                attack += 2;
                used = true;
                equipped.add("Sword");
            } else if(inventory.get(index).equals("Shield")) {
                defense += 2;
                used = true;
                equipped.add("Shield");
            } else if(inventory.get(index).equals("Armour")) {
                System.out.println("Armour");
                defense += 2;
                used = true;
                equipped.add("Armour");
            } else if(inventory.get(index).equals("Ring")) {
                attack += 2;
                used = true;
                equipped.add("Ring");
            }

            if(used) {
            inventoryCount.set(index, inventoryCount.get(index) - 1);
        if (inventoryCount.get(index) == 0) {
            inventory.remove(index);
            inventoryCount.remove(index);
            
            }
            }
    }

    public PVector getCenter() {
        PVector center = new PVector(this.position.x + (this.width / 2), this.position.y + (this.height / 2));
        return center;
    }
    
}

