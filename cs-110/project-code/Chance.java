/**
 Luke Pulaski
 CS 110

The category for Chance on the scorecard
 (takes the sum of all the values on the Die)
 */
public class Chance extends Category
{
    /**
     * Evaluates the Die in the ArrayList of Die and gives the potential
     * score for the Chance category
     * @param d The ArrayList of Die
     * @return The score that would be achieved for the Chance category
     */
    public int evaluate(Dice d)
    {
        return d.sum();
    }
}
