/**
 Luke Pulaski
 CS 110

 The category for Four of a Kind on the scorecard
 (scores the sum of the values on the Dice that have value 6)
 */

public class Sixes extends Category
{
    /**
     * Evaluates the Die in the ArrayList of Die and gives the potential
     * score for the Sixes category
     * @param d The ArrayList of Die
     * @return The score that would be achieved for the Sixes category
     */
    public int evaluate(Dice d)
    {
        return 6 * d.count(6);
    }
}
