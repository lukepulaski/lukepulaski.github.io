/**
 Luke Pulaski
 CS 110

 The Dice class is an initially empty container to add Die objects to
 */

import java.util.ArrayList;
public class Dice
{
    //instance variable
    private ArrayList<Die> dice; //a container for Die objects

    //class constant
    private static int DEF_CAP = 5; //default initial capacity of the ArrayList

    /**
     * Constructor creates the ArrayList with DEF_CAP capacity
     */
    public Dice()
    {
        dice = new ArrayList<Die>(DEF_CAP);
    }

    /**
     * Alternate constructor creates the ArrayList with a given capacity
     * @param num The capacity of the ArrayList
     */
    public Dice(int num)
    {
        dice = new ArrayList<Die>(num);
    }

    /**
     * Adds a Die to the end of the ArrayList
     * @param d The Die being added to the end of the ArrayList
     */
    public void addDie(Die d)
    {
        dice.add(d);
    }

    /**
     * Accessor method to the number of Die in the ArrayList
     * @return The number of Die in the ArrayList
     */
    public int getNumDice()
    {
        return dice.size();
    }

    /**
     * Accessor method to a specific Die in the ArrayList
     * @param i The index of the desired Die
     * @return The Die at index i
     */
    public Die getDie(int i)
    {
        return dice.get(i);
    }

    /**
     * Removes the Die at index i in the ArrayList
     * @param i The index of the Die to be removed
     */
    public void removeDie(int i)
    {
        dice.remove(i);
    }

    /**
     * Gives the number of Die in an ArrayList that have a specified value
     * @param val The desired Die value
     * @return The number of Die that have the specified value
     */
    public int count(int val)
    {
        int count = 0;
        for (Die d: dice)
        {
            if (d.getValue() == val)
                count++;
        }
        return count;
    }

    /**
     * Gives the sum of all the Die values in the ArrayList
     * @return The sum of all the Die values in the ArrayList
     */
    public int sum()
    {
        int sum = 0;
        for (Die d: dice)
        {
            sum += d.getValue();
        }
        return sum;
    }

    /**
     * Determines whether an ArrayList of Die contains a Die with a specified value
     * @param val The Die value being checked for presence in the ArrayList
     * @return True if the Die with the specified value is present, false otherwise
     */
    public boolean contains(int val)
    {
        boolean found = false;
        for (Die d: dice)
        {
            if (d.getValue() == val)
                found = true;
        }
        return found;
    }

    /**
     * Converts the index and the value of each Die in the ArrayList into a String
     * @return A String containing the index and the value of each Die in the ArrayList
     */
    @Override
    public String toString()
    {
        String s = "";
        int index = 0;
        for (Die d: dice)
        {
            index++;
            s += String.format("%d: value %d\n", index, d.getValue());
        }
        return s;
    }

}
