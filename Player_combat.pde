public class Player_combat {
    public String[] playerAttacks;
    public Terramor terramor;
    public Player player;
    int currentAttackType;
    HashMap<String, Object> attackGetter = new HashMap<String, Object>();
    public String aftereffectType = "";
    public boolean aftereffect = false;
    public String attackToRecur;
    public int roundsToRecur;
    public boolean textforHit = false;
    public boolean attackText = false;
    // boolean marked = false;
    
    
    public Player_combat(Terramor terramor, Player player) {
        this.terramor = terramor;
        this.player = player;
        this.playerAttacks = player.getAttacks();
    }
    
    public void playerAttack(int attackType) {
        attackType -= 1;
        currentAttackType = attackType;
        if (terramor.health > 0) {
            attackGetter = player.getAttack(playerAttacks[attackType]);
            if (!aftereffectType.equals("attack") && attackType != playerAttacks.length - 1) {
                player.critic_power_energy += (int)(attackGetter.get("critic_power"));
            } else if (attackType == playerAttacks.length - 1) {
                player.critic_power_energy -= 100;
            }
            //first checking if any aftereffects exist
             if (attackGetter.get("effect").equals("recurring") && aftereffect == false) {
                if (attackGetter.get("effect_name").equals("marked")) {
                    marked = true;
                    attackGetter.put("round_recurred", (int)attackGetter.get("round_recurred") + 1);
                } else if(attackGetter.get("effect_name").equals("attack")) {
                    if((int) random(0, 100)<50) {
                    weak = true;
                    attackGetter.put("round_recurred", (int)attackGetter.get("round_recurred") + 1);
                    }
                }
                aftereffect = true;
                aftereffectType = attackGetter.get("effect_name").toString();
            } else if (attackGetter.get("effect").equals("recurring") && aftereffect == true) {
                //if(aftereffectType.equals("marked")) {
                    attackGetter.put("round_recurred", (int)attackGetter.get("round_recurred") + 1);
                    if(attackGetter.get("round_recurred").equals(attackGetter.get("rounds"))) {
                        aftereffect = false;
                        aftereffectType = "";
                    }
                //}
            }
            
            if (accuracyofAttack() < (int)(attackGetter.get("accuracy")) && !aftereffectType.equals("attack")) {
                textforHit = true;
                terramor.health -= (int)(attackGetter.get("power"));
                attackGetter.put("round_used", currentRound);
                textforHit = true;
            } else {
                textforHit = false;
            }
            
            
        }
        if (terramor.health <= 0) {
            terramor.health = 0;
            won = true;
        }
    }
    
    
    
    public int getPlayerAttack() {
        if (player.critic_power_energy >= 100) {
            currentAttackType = playerAttacks.length - 1;
            return currentAttackType;
        } else if(currentAttackType == playerAttacks.length - 1) {
            return -1;
        }
        if (aftereffectType.equals("attack")) {
            return currentAttackType;
        }
        //println("current attack type: " + playerAttacks[currentAttackType]);
        attackGetter = player.getAttack(playerAttacks[currentAttackType]);
        // println((int)attackGetter.get("round_used"));
        if (currentRound - (int)attackGetter.get("round_used") < (int)attackGetter.get("cooldown")) {
            // Attack is inside cooldown period
            return -1;
        }
        return currentAttackType;
    }
    
    public String getPlayerAttackName(int attack) {
        if (currentAttackType == -1) {
            return "skip";
        } else  {
            return playerAttacks[attack - 1];
        }
    }
    
    public int accuracyofAttack() {
        if(marked) {
            return 10; //the accuracy of all the attacks implemented is inclusive of 10.
            //This means there is a 100% chance of hitting the monster if it is marked.
        } else {
            return(int) random(0, 101);
        }
    }
    
    public String getAvailableAttacks() {
        ArrayList<String> availableAttacks = new ArrayList<String>();
        for (int i = 0; i < playerAttacks.length - 2; i++) {
            attackGetter = player.getAttack(playerAttacks[i]);
            if (currentRound - (int) attackGetter.get("round_used") >= (int) attackGetter.get("cooldown")) {
                // Attack is outside cooldown period
                availableAttacks.add(playerAttacks[i]);
            }
        }
        if (availableAttacks.size() == 0) {
            return "skip";
        } else {
            int n = (int) random(0, availableAttacks.size() - 1);
            return availableAttacks.get(n);
        }
    }

    public int checkPlayerAttack(int attackTypeCheck) {
        currentAttackType = attackTypeCheck - 1;
        if(getPlayerAttack() == -1) {
            return -1;
        } else {
            return 1;
        }

    }
    
}
