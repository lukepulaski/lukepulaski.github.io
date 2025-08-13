/**
 Luke Pulaski
 CS 110

 The category for Four of a Kind on the scorecard
 (scores the sum of the values on the Die if four or
 more of the same value are present in the Dice)
 */

public class FourOfAKind extends Category
{
    /**
     * Evaluates the Die in the ArrayList of Die and gives the potential
     * score for the Four of a Kind category
     * @param d The ArrayList of Die
     * @return The score that would be achieved for the Four of a Kind category
     */
    public int evaluate(Dice d)
    {
        if (d.count(1) >= 4 || d.count(2) >= 4 || d.count(3 ) >= 4 ||
                d.count(4) >= 4 || d.count(5) >= 4 || d.count(6) >= 4)
            return d.sum();
        else
            return 0;
    }
}
