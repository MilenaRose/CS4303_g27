//PVector monsterPos;
//PVector playerPos;
public class Combat {
    public Monster monster;
    public Player player;
    String[] playerAttacks;
    public boolean textforHit = false;
    public boolean attackText = false;


    public Combat(Player player,Monster monster) {
        this.player = player;
        this.monster = monster;
        this.playerAttacks = player.getAttacks();
        //monsterPos = new PVector(width - 700, 300);
        //playerPos = new PVector(370, height - 400);
    }
    

    public void combatDisplay(){
        float sectionLength = width/5;
        textSize(150);
        fill(0);
        text("P", 370, height - 400);
        text("M", width - 700, 300);
        textSize(50);
        text("Your Health : " + player.health +"/" + player.max_health, 250, height -300);
        text("Monster Health : " + monster.health + "/" + monster.max_health, width - 790, 140);

        textSize(20);
        //if needed
        //text("Enter your choice", 40, height - 200);
        textSize(50);
        text("1 - " + playerAttacks[0], sectionLength - 150 , height - 150);
        text("2 - " + playerAttacks[1], 2*sectionLength - 150, height - 150);
        text("3 - " + playerAttacks[2], 3*sectionLength - 150, height - 150); // if hit reduces monster defense by 25% chance to hit.
        text("4 - " + playerAttacks[3] , 4*sectionLength - 150, height - 150); // if hit reduces monster attack by 50% chance to hit.
        textSize(25);
        fill(35,35,35);
        text("Attack : " + player.attack, 40, height - 360);
        text("Defense : " + player.defense, 40, height - 330);
        fill(0);
        text("Attack : " + monster.attack, width - 250, 200);
        text("Defense : " + monster.defense, width - 250, 230);
        if(attackText) {if(textforHit) {text("Hit!", width/2, height - 200);
         } else { text("Miss!", width/2, height - 200);
    }
        }
    }

    public void attack(int attackType) {
        attackText = true;
        if(monster.health > 0) {
            if(random(0,1) > 0.5) {
                monster.health -= player.attack;
                textforHit = true;
            }
            if(monster.health <= 0) {
                monster.health = 0;
                player.xp += monster.xp;
                return;
            }
        }
    }

    public boolean attackAnimation() {
        pushMatrix();
        translate(playerPos.x, playerPos.y);
        //translate(monsterPos.x, monsterPos.y);
        //PVector mouse = new PVector(mouseX, mouseY);
        PVector direction = monsterPos.sub(playerPos);
        //PVector direction = playerPos.sub(monsterPos);
        //PVector direction = mouse.sub(playerPos);
        println(direction.x);
        //println(height+"height");
        println(direction.y);
        //line(0,0,width/2,height/2);
        //ellipse(0, 0, 200,200);
        //fill(0);
        println(monsterPos.x);
        println(monsterPos.y);

        line(0, 0, direction.x, direction.y);
        popMatrix();

        return true;
    }

    // public boolean attackAnimationMonster() {
    //     pushMatrix();
    //     translate(width - 700, 300);
    //     popMatrix();
    //     return true;
    // }

    public void spell() {
        attackText = true;
        if(monster.defense > 0) {
            if(random(0,1) > 0.25) {
            monster.defense -= 1;
            textforHit = true;
            }
        }
    }

    public void enchantment() {
        attackText = true;
        if(monster.attack > 1) {
            if(random(0,1) > 0.5) {
            monster.attack -= 1;
            textforHit = true;
            } 
        }
    }

    // public void run() {
    //     //player is teleported to a the default spawning point
    //         PVector pos = dungeon.randomPosPlayer();
    //         player.teleport(pos);
    // }

    public void monsterAttack() {
        if(player.health > 0) {
            if(random(0,1) > 0.5) {
                player.health -= monster.attack;
            }
        } else {
            exit();
        }
    }
}