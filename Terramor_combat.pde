
public class Terramor_combat {
    public String[] playerAttacks;
    public Terramor terramor;
    public Player player;
    public String[] terramorAttacks;
    int currentAttackType;
    HashMap<String, Object> attackGetter = new HashMap<String, Object>();
    public String aftereffectType = "";
    public boolean aftereffect = false;
    public String attackToRecur;
    public int roundsToRecur;
    //public boolean textforHit = false;
    //public boolean attackText = false;
    
    
    public Terramor_combat(Terramor terramor, Player player) {
        this.terramor = terramor;
        this.player = player;
        this.terramorAttacks = terramor.getAttacks();
        this.playerAttacks = player.getAttacks();
    }
    
    // public void attack(int attackType) {
    //     attackText = true;
    //     if (terramor.health > 0) {
    //         // if (random(0,1) > 0.5) {
    //         terramor.health -= player.attack;
    //         textforHit = true;
    //     // } else {
    //         //     textforHit = false;
    //     // }
    //     }
    // }
    public void monsterAttack() {
        if (currentAttackType == -1) {
            return;
        }
        if (player.health > 0) {
            attackGetter = terramor.getAttack(terramorAttacks[currentAttackType]);
            if (!aftereffectType.equals("attack") && currentAttackType != terramorAttacks.length - 1) {
                terramor.critic_power_energy += (int)(attackGetter.get("critic_power"));
            } else if (currentAttackType == terramorAttacks.length - 1) {
                terramor.critic_power_energy -= 100;
            }
            //first checking if any aftereffects exist
            if (aftereffect == true && aftereffectType.equals("attack")) {
                if (accuracyofAttack() < (int)(attackGetter.get("accuracy"))) {
                    textforHit = true;
                    player.health -= (int)(attackGetter.get("power"));
                } else {
                    textforHit = false;
                }
                //counting the rounds               
                roundsToRecur -= 1;
                if (roundsToRecur == 1) {
                    aftereffect = false;
                    aftereffectType = "";
                }
            } else if (attackGetter.get("effect").equals("recurring")) {
                aftereffect = true;
                aftereffectType = "attack";
                attackToRecur = terramorAttacks[currentAttackType];
                roundsToRecur = (int)(attackGetter.get("rounds"));
            }
            
            if (accuracyofAttack() < (int)(attackGetter.get("accuracy")) && !aftereffectType.equals("attack")) {
                textforHit = true;
                player.health -= (int)(attackGetter.get("power"));
                attackGetter.put("round_used", currentRound);
            } else {
                textforHit = false;
            }
            
            
        }
        if (player.health <= 0) {
            player.health = 0;
            lost = true;
        }
    }
    
    
    
    public int getMonsterAttack() {
        if (terramor.critic_power_energy >= 100) {
            currentAttackType = terramorAttacks.length - 1;
            return currentAttackType;
        }
        int availableAttackType = -1; // Initialize with a special value
        if (aftereffectType.equals("attack")) {
            return currentAttackType;
        }
        currentAttackType = (int) random(0, terramorAttacks.length - 2);
        attackGetter = terramor.getAttack(terramorAttacks[currentAttackType]);
        if (currentRound - (int)attackGetter.get("round_used") < (int)attackGetter.get("cooldown")) {
            String nextAttack = getAvailableAttacks();
            if (nextAttack.equals("skip")) {
                currentAttackType = -1;
                
            } else {
                attackGetter = terramor.getAttack(nextAttack);
                currentAttackType = (int)attackGetter.get("id");
            }
        }
        return currentAttackType;
    }
    
    public String getMonsterAttackName() {
        if (currentAttackType == -1) {
            return "skip";
        } else  {
            return terramorAttacks[currentAttackType];
        }
    }
    
    public int accuracyofAttack() {
        if(weak) {
            return(int) random(40,100);
        } else {
        return(int) random(0, 101);
        }
    }
    
    public String getAvailableAttacks() {
        ArrayList<String> availableAttacks = new ArrayList<String>();
        for (int i = 0; i < terramorAttacks.length - 2; i++) {
            attackGetter = terramor.getAttack(terramorAttacks[i]);
            if (currentRound - (int) attackGetter.get("round_used") >= (int) attackGetter.get("cooldown")) {
                // Attack is outside cooldown period
                availableAttacks.add(terramorAttacks[i]);
            }
        }
        if (availableAttacks.size() == 0) {
            return "skip";
        } else {
            int n = (int) random(0, availableAttacks.size() - 1);
            return availableAttacks.get(n);
        }
    }
    
    
    public void combatDisplay() {
        float sectionLength = width / 5;
        textSize(150);
        fill(0);
        text("P", 370, height - 400);
        text("M", width - 700, 300);
        textSize(50);
        text("Your Health : " + player.health + "/" + player.max_health, 250, height - 300);
        text("Monster Health : " + terramor.health + "/" + terramor.max_health, width - 790, 140);
        
        textSize(20);
        //if needed
        //text("Enter your choice", 40, height - 200);
        textSize(50);
        text("1 - " + playerAttacks[0], sectionLength - 150 , height - 150);
        text("2 - " + playerAttacks[1], 2 * sectionLength - 150, height - 150);
        text("3 - " + playerAttacks[2], 3 * sectionLength - 60, height - 150); // if hit reduces monster defense by 25% chance to hit.
        text("4 - " + playerAttacks[3] , 4 * sectionLength - 100, height - 150); // if hit reduces monster attack by 50% chance to hit.
        //text("5 - " + playerAttacks[4], 2 * sectionLength - 60, height - 80); // if hit reduces monster attack by 50% chance to hit.
        textSize(25);
        fill(35,35,35);
        text("Crticial energy : " + player.critic_power_energy, 40, height - 360);
        text("God Level : " + player.god_level, 40, height - 330);
        fill(0);
        text("Critical energy : " + terramor.critic_power_energy, width - 250, 200);
        text("God Level : " + terramor.god_level, width - 250, 230);
        if(marked) {
            text("Marked", width - 250, 260);
        }
        //println(attackText);
        if (attackText) {if (textforHit) {text("Hit!", width / 2, height / 2);
        } else { text("Miss!", width / 2, height / 2);
            }
        }
    }
}
