/**
 Luke Pulaski
 CS 110

 The Die class represents a single die
 */

import java.util.Random;
public class Die
{
    //instance variable
    private int value; //the value on the die

    //class variable
    private static Random r; //random number generator for all Die to share

    //class constant
    private static int SIDES = 6; //the number of sides on a die

    /**
     * Constructor initializes value to a random number between 1 and SIDES
     */
    public Die()
    {
        r = new Random();
        roll();
    }

    /**
     * Changes the value on the die to a random value between 1 and SIDES
     */
    public void roll()
    {
        value = 1 + r.nextInt(SIDES);
    }

    /**
     * Accessor method to the value on the die
     * @return the value on the die
     */
    public int getValue()
    {
        return value;
    }

    /**
     * Converts a single integer value representing the value on
     * the die into a String
     * @return A String containing the value on the die
     */
    @Override
    public String toString()
    {
        return String.format("%d", getValue());
    }

}
