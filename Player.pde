import java.util.HashMap;
public class Player {
    PVector position = new PVector(0, 0);
    float width;
    float height;
    int health;
    int max_health;
    int max_attack;
    int max_defense;
    int attack;
    int defense;
    int critic_power_energy = 0;
    int xp;
    int god_level = 15;
    PVector initialPosition = new PVector(0, 0);
    PVector velocity = new PVector(0, 0);
    ArrayList<String> equipped = new ArrayList<String>();
    ArrayList<String> inventory = new ArrayList<String>();
    ArrayList<Integer> inventoryCount = new ArrayList<Integer>();
    String[] attacks = {"Soul Reap", "Mortal Desolation", "Death Mark", "Eternal Torment"};
    HashMap<String, Object> soul_reap = new HashMap<String, Object>();
    HashMap<String, Object> mortal_desolation = new HashMap<String, Object>();
    HashMap<String, Object> death_mark = new HashMap<String, Object>();
    HashMap<String, Object> Attack4 = new HashMap<String, Object>();
    HashMap<String, Object> eternal_torment = new HashMap<String, Object>();
    ArrayList<HashMap<String, Object>> attackList = new ArrayList<>();
    
    Player(float x, float y, float width, float height) {
        this.position.x = x;
        this.position.y = y;
        this.initialPosition.x = x;
        this.initialPosition.y = y;
        this.width = width;
        this.height = height;
        max_health = 100;
        // max_attack = 10;
        // max_defense = 10;
        health = max_health;
        // attack = 2;
        // defense = 10;
        // xp = 0;
        initiateAttacks();
        initialiseAttackList();
    }
    
    public void displayPlayer() {
        fill(255);
        strokeWeight(0);
        rect(this.position.x, this.position.y, this.width, this.height);
    }
    
    public void inventoryDisplay() {
        int yPosVal = 140;
        
        for (int i = 0; i < attackList.size(); i++) {
            int xPosVal = 40;
            push();
            fill(0);
            textSize(50);
            text(String.valueOf(attackList.get(i).get("name")), xPosVal, yPosVal);
            
            textSize(20);
            yPosVal += 45;
            xPosVal += 20;
            
            fill(110);
            text("Desc: " + attackList.get(i).get("description"), xPosVal, yPosVal);
            yPosVal += 80;
            fill(255, 0, 0);
            text("Power: " + attackList.get(i).get("power"), xPosVal, yPosVal);
            xPosVal += 200;
            fill(0, 255, 0);
            text("Accuracy: " + attackList.get(i).get("accuracy"), xPosVal, yPosVal);
            xPosVal += 200;
            fill(0, 0, 255);
            text("CoolDown: " + attackList.get(i).get("cooldown"), xPosVal, yPosVal);
            yPosVal += 100;
            pop();
        }
    }
    
    public void initiateAttacks() {
        //Soul reap
        soul_reap.put("name", "Soul Reap"); 
        soul_reap.put("power", 25); //damage of the attack
        soul_reap.put("accuracy", 90); //chance of the attack hitting
        soul_reap.put("cost", 30); //cost of the attack (Celestial Energy)
        soul_reap.put("charges",2); //charges for 1 round before attacking
        soul_reap.put("cooldown", 2); //cooldown of 2 rounds
        soul_reap.put("effect", 0); //no effect
        soul_reap.put("effect_chance", 0); //no effect
        soul_reap.put("effect_duration", 0); //no effect
        soul_reap.put("effect_damage", 0); //no effect
        soul_reap.put("evasion", "no"); //cannot be evaded
        soul_reap.put("blocked", "yes"); //can be blocked
        soul_reap.put("type", "energy"); //energy attack 
        soul_reap.put("critic_power", 10); //critical power energy increases by 10
        soul_reap.put("health_taken", 20); //health taken by the user
        soul_reap.put("round_used", 0); //round used
        soul_reap.put("round_recurred", 0); //round charged
        soul_reap.put("description", "The player reaches out with their divine touch, draining the life force from their enemies.\n With a single touch, they sever the connection between body and soul, instantly claiming the life essence of their foes.");
        //Geomantic Rupture
        mortal_desolation.put("name", "Mortal Desolation"); 
        mortal_desolation.put("power", 40); //damage of the attack
        mortal_desolation.put("accuracy", 75); //chance of the attack hitting
        mortal_desolation.put("cost", 40); //cost of the attack (Celestial Energy)
        mortal_desolation.put("charges",1); //no charge,sudden attack
        mortal_desolation.put("cooldown", 2); //cooldown of 2 rounds
        mortal_desolation.put("effect", "recurring"); //no effect
        mortal_desolation.put("rounds", 2); //effect lasts for 5 rounds
        mortal_desolation.put("effect_name", "vulnerable"); //no effect
        mortal_desolation.put("effect_chance", 50); //no effect
        mortal_desolation.put("effect_duration", 2); //no effect
        mortal_desolation.put("effect_damage", 0); //no effect
        mortal_desolation.put("evasion", "yes"); //can be evaded
        mortal_desolation.put("blocked", "yes"); //can be blocked
        mortal_desolation.put("type", "energy"); //physical attack
        mortal_desolation.put("critic_power", 15); //critical power energy increases by 10
        mortal_desolation.put("round_used", 0); //round used
        mortal_desolation.put("round_recurred", 0); //round charged
        mortal_desolation.put("description", "The player unleashes a wave of deathly energy that spreads through the battlefield, inducing decay and deterioration upon all it touches.\n The very essence of life crumbles before them, leaving their enemies weakened and vulnerable.");
        //death_mark
        death_mark.put("name", "Death's Mark");
        death_mark.put("power", randomPower()); //damage of the attack
        death_mark.put("accuracy", 50); //chance of the attack hitting
        death_mark.put("cost", 15); //cost of the attack (Celestial Energy)
        death_mark.put("rounds",3); //attacks for 3 rounds before stopping
        death_mark.put("cooldown", 2); //cooldown of 3 rounds
        death_mark.put("effect", "recurring"); //recurring attack
        death_mark.put("rounds",3);// effect lasts for 3 rounds
        death_mark.put("effect_name", "marked"); //no effect
        death_mark.put("effect_chance", 0); //no effect
        death_mark.put("effect_duration", 0); //no effect
        death_mark.put("effect_damage", 0); //no effect
        death_mark.put("evasion", "yes"); //can be evaded
        death_mark.put("blocked", "yes"); //can be blocked
        death_mark.put("type", "physical"); //physical attack
        death_mark.put("critic_power", 5); //critical power energy increases by 5
        death_mark.put("round_used", 0); //round used
        death_mark.put("round_recurred", 0); //rounds recurred
        death_mark.put("description", "The player imbues their weapon with the essence of death, branding the enemy with a sigil that signifies their impending demise.\n This mark weakens the foe, making them more susceptible to subsequent attacks and draining their life force with every strike.");
        //Planetary Devastation
        //can only be used once per battle
        //and when critical power energy is at 100
        eternal_torment.put("name", "Eternal Torment"); 
        eternal_torment.put("power", 300); //damage of the attack
        eternal_torment.put("accuracy", 90); //chance of the attack hitting
        eternal_torment.put("charges",0); //no charge,sudden
        eternal_torment.put("cooldown", 1000); //cooldown of 5 rounds
        eternal_torment.put("effect", 0); //no effect
        eternal_torment.put("effect_chance", 0); //no effect
        eternal_torment.put("effect_duration", 0); //no effect
        eternal_torment.put("effect_damage", 0); //no effect
        eternal_torment.put("evasion", "no"); //cannot be evaded
        eternal_torment.put("type", "energy");
        eternal_torment.put("blocked", "no"); //cannot be blocked
        eternal_torment.put("description", "In a display of unimaginable power, the player summons forth an apocalyptic eclipse, shrouding the entire battlefield in an unsettling darkness.\n As the celestial bodies align, a miasma of despair and anguish permeates the air.");
    }
    
    public void initialiseAttackList() {
        attackList.add(soul_reap);
        attackList.add(mortal_desolation);
        attackList.add(death_mark);
        attackList.add(eternal_torment);
    }
    
    public int randomPower() {
        int power = (int)(Math.random() * 16) + 6;
        return power;
    }
    
    public String[] getAttacks() {
        return attacks;
    }
    
    public HashMap<String, Object> getAttack(String attack) {
        if (attack.equals("Soul Reap")) {
            return soul_reap;
        }
        else if (attack.equals("Mortal Desolation")) {
            return mortal_desolation;
        }
        else if (attack.equals("Death Mark")) {
            return death_mark;
        }
        else if (attack.equals("Eternal Torment")) {
            return eternal_torment;
        }
        else{
            return soul_reap;
        }
    }
}


// DeathMark
// Death's Mark: The player imbues their weapon with the essence of death, branding the enemy with a sigil that signifies their impending demise. This mark weakens the foe, 
// making them more susceptible to subsequent attacks and draining their life force with every strike.

// Mortal Desolation: The player unleashes a wave of deathly energy that spreads through the battlefield, inducing decay and deterioration upon all it touches. The very essence 
// of life crumbles before them, leaving their enemies weakened and vulnerable.

// Soul Reap: The player reaches out with their divine touch, draining the life force from their enemies. With a single touch, they sever the connection between body and soul, 
// instantly claiming the life essence of their foes.

// Eclipse of Eternal Torment: In a display of unimaginable power, the player summons forth an apocalyptic eclipse, shrouding the entire battlefield in an unsettling darkness. 
// As the celestial bodies align, a miasma of despair and anguish permeates the air.
// Within the darkness, the player channels the collective suffering and fear of all living beings, transforming it into a devastating wave of malevolent energy. This wave washes 
// over their enemies, subjecting them to an eternal torment that transcends physical pain.
// As the Eclipse of Eternal Torment engulfs the foes, their minds become haunted by nightmarish visions, their souls gripped by an unrelenting agony. Time itself seems to stand 
// stillas the adversaries experience an eternity of suffering within mere moments.
// The dreadful power of this final move leaves no trace of resistance, as the enemies are reduced to mere husks of their former selves, stripped of hope and consumed by 
// eternal darkness. The battlefield becomes a chilling tableau of despair and desolation, bearing witness to the overwhelming might of the god of death.

