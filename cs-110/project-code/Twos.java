/**
 Luke Pulaski
 CS 110

 The category for Twos on the scorecard
 (scores the sum of the values on the Dice that have value 2)
 */

public class Twos extends Category
{
    /**
     * Evaluates the Die in the ArrayList of Die and gives the potential
     * score for the Twos category
     * @param d The ArrayList of Die
     * @return The score that would be achieved for the Twos category
     */
    public int evaluate(Dice d)
    {
        return 2 * d.count(2);
    }
}
