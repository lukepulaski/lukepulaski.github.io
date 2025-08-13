/**
 Luke Pulaski
 CS 110

 The DiceRoll class is a specialization of the Dice class that allows
 rolling all the Die in the collection
 */

public class DiceRoll extends Dice
{
    //class constant
    public static int NUM_DIE = 5; //the number of Die that will be rolled

    /**
     * Constructor fills the Dice object with NUM_DIE Die objects
     */
    public DiceRoll()
    {
        super(NUM_DIE);
    }

    /**
     * Rolls each of the Die in the Dice ArrayList
     */
    public void toss()
    {
        for (int i = 0; i < super.getNumDice(); i++)
            getDie(i).roll();
    }

}
