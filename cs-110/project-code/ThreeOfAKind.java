/**
 Luke Pulaski
 CS 110

 The category for Three of a Kind on the scorecard
 (scores the sum of the values on the Die if three or
 more of the same value are present in the Dice)
 */

public class ThreeOfAKind extends Category
{
    /**
     * Evaluates the Die in the ArrayList of Die and gives the potential
     * score for the Three of a Kind category
     * @param d The ArrayList of Die
     * @return The score that would be achieved for the Three of a Kind category
     */
    public int evaluate(Dice d)
    {
        if (d.count(1) >= 3 || d.count(2) >= 3 || d.count(3 ) >= 3 ||
                d.count(4) >= 3 || d.count(5) >= 3 || d.count(6) >= 3)
            return d.sum();
        else
            return 0;
    }
}
