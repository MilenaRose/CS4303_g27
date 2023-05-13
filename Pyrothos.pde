//Pyrothos : the Infernal Pyromancer (Power: Heat and Energy Manipulation)
import java.util.HashMap;
class Pyrothos {
    int max_health = 1000;
    HashMap<String, Object> celestial_connection = new HashMap<String, Object>();
    HashMap<String, Object> energy_Absorption = new HashMap<String, Object>();
    HashMap<String, Object> inferno_Nova = new HashMap<String, Object>();
    HashMap<String, Object> astral_Incineration = new HashMap<String, Object>();
    HashMap<String, Object> stellar_Pheonix_Rebirth = new HashMap<String, Object>();
    int critic_power_energy = 0;
    int agility = 0;
    int god_level = 50;
    int defense = 0;
    int health;
    public Pyrothos() {
        health = max_health;
        initiateAttacks();
    }

    public void initiateAttacks(){
        //Celestial Connection
        //The ability to raise or lower temperatures at will, 
        //creating searing heatwaves or freezing cold blasts across the realm.
        celestial_connection.put("power", 15);
        celestial_connection.put("accuracy", 100);
        celestial_connection.put("cost", 20);
        celestial_connection.put("type", "energy");
        celestial_connection.put("effect", "recurring");
        celestial_connection.put("rounds", "all");
        celestial_connection.put("cooldown", 0);
        celestial_connection.put("effect_type", "heatwave"); //no effect
        celestial_connection.put("effect_chance", 40); //no effect
        celestial_connection.put("effect_duration", "all"); //no effect
        celestial_connection.put("effect_damage", 10); //no effect
        celestial_connection.put("evasion", "no"); //no effect
        celestial_connection.put("blocked", "no"); //cannot be blocked
        celestial_connection.put("critic_power", 5); //critical power energy incre
        //Energy Absorption
        //Pyrothos can absorb various forms of energy, such as thermal, electrical, or kinetic energy, to strengthen themselves or negate attacks.
        //increases the defense or increase healing
        //AI prioritizes health if below 50% and defense if above 50%
        //Will negate attacks if it is energy based
        energy_Absorption.put("power", 0);
        energy_Absorption.put("accuracy", 100);
        energy_Absorption.put("cost", 30);
        energy_Absorption.put("type", "energy");
        energy_Absorption.put("effect", 0);
        energy_Absorption.put("cooldown", 2);
        energy_Absorption.put("effect_chance", 0); //no effect
        energy_Absorption.put("effect_duration", 0); //no effect
        energy_Absorption.put("effect_damage", 0); //no effect
        energy_Absorption.put("evasion", "no"); //no effect
        energy_Absorption.put("blocked", "no"); //cannot be blocked
        energy_Absorption.put("critic_power", 10); //critical power energy incre
        //Inferno Nova 
        // Pyrothos unleashes a devastating explosion of concentrated heat energy, disintegrating everything caught within its fiery blast radius.   
        inferno_Nova.put("power", 70);
        inferno_Nova.put("accuracy", 60);
        inferno_Nova.put("cost", 40);
        inferno_Nova.put("type", "energy");
        inferno_Nova.put("effect", 0);
        inferno_Nova.put("cooldown", 3);
        inferno_Nova.put("effect_chance", 0); //no effect
        inferno_Nova.put("effect_duration", 0); //no effect
        inferno_Nova.put("effect_damage", 0); //no effect
        inferno_Nova.put("evasion", "yes"); //can be evaded
        inferno_Nova.put("blocked", "no"); //cannot be blocked
        inferno_Nova.put("critic_power", 15); //critical power energy incre
        //Astral Incineration
        //Pyrothos conjures celestial fireballs infused with cosmic energy, launching them in a cascading barrage. Each fireball detonates on impact, creating fiery explosions that ravage the battlefield and leave adversaries in ashes.
        astral_Incineration.put("power", 15);
        astral_Incineration.put("accuracy", 50);
        astral_Incineration.put("cost", 60);
        astral_Incineration.put("type", "physical");
        astral_Incineration.put("effect", 0);
        astral_Incineration.put("multiplier", randomMultiplier()); //number of times this attack will take place
        astral_Incineration.put("cooldown", 4);
        astral_Incineration.put("effect_chance", 0); //no effect
        astral_Incineration.put("effect_duration", 0); //no effect
        astral_Incineration.put("effect_damage", 0); //no effect
        astral_Incineration.put("evasion", "yes"); //can be evaded
        astral_Incineration.put("blocked", "no"); //cannot be blocked
        astral_Incineration.put("critic_power", 20); //critical power energy incre
        //Stellar Pheonix Rebirth
        // When pushed to the brink, Pyrothos harnesses the power of a dying star, absorbing its energy to rejuvenate themselves. In a blinding surge of celestial fire, they rise anew, their strength and power multiplied, ready to unleash devastation upon their foes.
        stellar_Pheonix_Rebirth.put("power", 0);
        stellar_Pheonix_Rebirth.put("accuracy", 100);
    }

    public int randomMultiplier(){
        int multiplier = (int)(Math.random() * 5) + 1;
        return multiplier;
    }
}