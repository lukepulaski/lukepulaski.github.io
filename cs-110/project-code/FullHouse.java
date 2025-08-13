/**
 Luke Pulaski
 CS 110

 The category for Full House on the scorecard
 (scores the sum of the values on the Die if three of the
 same value are present in the Dice and two of another value
 are present as well)
 */

public class FullHouse extends Category
{
    /**
     * Evaluates the Die in the ArrayList of Die and gives the potential
     * score for the Full House category
     * @param d The ArrayList of Die
     * @return The score that would be achieved for the Full House category
     */
    public int evaluate(Dice d)
    {
        if (d.count(1) == 3 || d.count(2) == 3 || d.count(3) == 3 ||
                d.count(4) == 3 || d.count(5) == 3 || d.count(6) == 3)
        {
            if (d.count(1) == 2 || d.count(2) == 2 || d.count(3) == 2 ||
                    d.count(4) == 2 || d.count(5) == 2 || d.count(6) == 2)
                return 25;
            else
                return 0;
        }
        else
            return 0;
    }
}
