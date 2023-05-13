// Terramor, the Great Guardian of Planets
import java.util.HashMap;
class Terramor{
    int max_health = 500;
    int health;
    // attacks
    String[] attacks = {"Cosmic Resonance", "Geomantic Rupture", "Terraforge", "Stellar Grasp", "Planetary Devastation"};
    HashMap<String, Object> cosmic_Resonance = new HashMap<String, Object>();
    HashMap<String, Object> geomantic_Rupture = new HashMap<String, Object>();
    HashMap<String, Object> planetary_Devastation = new HashMap<String, Object>();
    HashMap<String, Object> stellar_Grasp = new HashMap<String, Object>();
    HashMap<String, Object> terraforge = new HashMap<String, Object>();
    // stats
    int critic_power_energy = 0;
    int agility = 0;
    int god_level = 25;
    int defense = 0;
    // invoking the constructor of the superclass
    public Terramor() {
        health = max_health;
        initiateAttacks();
    }

    public void initiateAttacks(){
        //Cosmic resonance
        cosmic_Resonance.put("power", 20); //damage of the attack
        cosmic_Resonance.put("accuracy", 80); //chance of the attack hitting
        cosmic_Resonance.put("cost", 30); //cost of the attack (Celestial Energy)
        cosmic_Resonance.put("charges",1); //charges for 1 round before attacking
        cosmic_Resonance.put("cooldown", 1); //cooldown of 3 rounds
        cosmic_Resonance.put("effect", 0); //no effect
        cosmic_Resonance.put("effect_chance", 0); //no effect
        cosmic_Resonance.put("effect_duration", 0); //no effect
        cosmic_Resonance.put("effect_damage", 0); //no effect
        cosmic_Resonance.put("evasion", "no"); //cannot be evaded
        cosmic_Resonance.put("blocked", "yes"); //can be blocked
        cosmic_Resonance.put("type", "energy"); //energy attack 
        cosmic_Resonance.put("critic_power", 10); //critical power energy increases by 10 
        cosmic_Resonance.put("round_used", 0); //round used
        //Geomantic Rupture
        geomantic_Rupture.put("power", 35); //damage of the attack
        geomantic_Rupture.put("accuracy", 75); //chance of the attack hitting
        geomantic_Rupture.put("cost", 40); //cost of the attack (Celestial Energy)
        geomantic_Rupture.put("charges",0); //no charge,sudden attack
        geomantic_Rupture.put("cooldown", 2); //cooldown of 2 rounds
        geomantic_Rupture.put("effect", 0); //no effect
        geomantic_Rupture.put("effect_chance", 0); //no effect
        geomantic_Rupture.put("effect_duration", 0); //no effect
        geomantic_Rupture.put("effect_damage", 0); //no effect
        geomantic_Rupture.put("evasion", "yes"); //can be evaded
        geomantic_Rupture.put("blocked", "yes"); //can be blocked
        geomantic_Rupture.put("type", "physical"); //physical attack
        geomantic_Rupture.put("critic_power", 10); //critical power energy increases by 10
        geomantic_Rupture.put("round_used", 0); //round used
        //terraforge
        terraforge.put("power", randomPower()); //damage of the attack
        terraforge.put("accuracy", 55); //chance of the attack hitting
        terraforge.put("cost", 15); //cost of the attack (Celestial Energy)
        terraforge.put("rounds",3); //attacks for 3 rounds before stopping
        terraforge.put("cooldown", 2); //cooldown of 3 rounds
        terraforge.put("effect", "recurring"); //recurring attack
        terraforge.put("effect_name", "attack"); //attack is recurring
        terraforge.put("effect_chance", 0); //no effect
        terraforge.put("effect_duration", 0); //no effect
        terraforge.put("effect_damage", 0); //no effect
        terraforge.put("evasion", "yes"); //can be evaded
        terraforge.put("blocked", "yes"); //can be blocked
        terraforge.put("type", "physical"); //physical attack
        terraforge.put("critic_power", 5); //critical power energy increases by 5
        terraforge.put("round_used", 0); //round used
        //Stellar Grasp
        stellar_Grasp.put("power", 45); //damage of the attack
        stellar_Grasp.put("accuracy", 65); //chance of the attack hitting
        stellar_Grasp.put("cost", 50); //cost of the attack (Celestial Energy)
        stellar_Grasp.put("charges",1); //charges for 1 round before attacking
        stellar_Grasp.put("cooldown", 3); //cooldown of 3 rounds
        stellar_Grasp.put("effect", 0); //no effect
        stellar_Grasp.put("effect_chance", 0); //no effect
        stellar_Grasp.put("effect_duration", 0); //no effect
        stellar_Grasp.put("effect_damage", 0); //no effect
        stellar_Grasp.put("evasion", "yes"); //cannot be evaded
        stellar_Grasp.put("blocked", "no"); //can be blocked
        stellar_Grasp.put("type", "physical"); //physical attack
        stellar_Grasp.put("critic_power", 15); //critical power energy increases by 10
        stellar_Grasp.put("round_used", 0); //round used
        //Planetary Devastation
        //can only be used once per battle
        //and when critical power energy is at 100
        planetary_Devastation.put("power", 1000); //damage of the attack
        planetary_Devastation.put("accuracy", 90); //chance of the attack hitting
        planetary_Devastation.put("charges",0); //no charge,sudden
        planetary_Devastation.put("cooldown", 1000); //cooldown of 5 rounds
        planetary_Devastation.put("effect", 0); //no effect
        planetary_Devastation.put("effect_chance", 0); //no effect
        planetary_Devastation.put("effect_duration", 0); //no effect
        planetary_Devastation.put("effect_damage", 0); //no effect
        planetary_Devastation.put("evasion", "no"); //cannot be evaded
        planetary_Devastation.put("type", "physical");
        planetary_Devastation.put("blocked", "no"); //cannot be blocked
    }

    public int randomPower(){
        int power = (int) (Math.random() * 16) + 6;
        return power;
    }

    public String[] getAttacks(){
        return attacks;
    }

    public HashMap<String, Object> getAttack(String attack){
        if(attack.equals("Cosmic Resonance")){
            return cosmic_Resonance;
        }
        else if(attack.equals("Geomantic Rupture")){
            return geomantic_Rupture;
        }
        else if(attack.equals("Terraforge")){
            return terraforge;
        }
        else if(attack.equals("Stellar Grasp")){
            return stellar_Grasp;
        }
        else if(attack.equals("Planetary Devastation")){
            return planetary_Devastation;
        }
        else{
            return null;
        }
}
}
// Cosmic Resonance: Terramor taps into the cosmic energy flowing through the planets, unleashing a devastating shockwave of power. This energy surge disrupts 
// the very fabric of reality, causing damage on a massive scale.

// Geomantic Rupture: Terramor taps into the raw power of the planet's core, causing a localized eruption. The ground splits open, spewing forth geysers of 
// molten lava, scorching anything in their path

//Stellar Grasp: Terramor reaches out to the celestial realm, pulling down a meteor shower from the skies. Meteors rain down upon the battlefield, decimating 
// enemies with explosive impact.

// terraforge: Terramor summons molten rock and volcanic fire, forging them into blazing projectiles. They hurl these fiery boulders at enemies, engulfing 
// them in searing flames upon impact.

// Planetary Devastation: Terramor taps into the core of the planet, channeling the raw elemental forces of earth, fire, and celestial energy. With a mighty roar, 
// Terramor unleashes a cataclysmic surge of power that engulfs the entire battlefield. The ground ruptures, releasing torrents of molten lava, volcanic ash, and 
// swirling celestial energy. The destructive energy sweeps across the area, obliterating everything in its path. Structures crumble, the earth splits open, and 
// a storm of fiery projectiles rains down upon foes. The sheer magnitude of the attack leaves a scarred and desolate landscape in its wake, with the power to 
// reshape the terrain and leave enemies devastated.

// "Planetary Devastation" is a truly devastating attack that harnesses the full might of Terramor's godly powers, showcasing their ability to unleash unparalleled
//  destruction upon their adversaries and leave a lasting impact on the battlefield.