/**
 Luke Pulaski
 CS 110

 The category for Five of a Kind on the scorecard
 (scores the sum of the values on the Die if all five Dice
 have the same value)
 */

public class FiveOfAKind extends Category
{
    /**
     * Evaluates the Die in the ArrayList of Die and gives the potential
     * score for the Yahtzee category
     * @param d The ArrayList of Die
     * @return The score that would be achieved for the Yahtzee category
     */
    public int evaluate(Dice d)
    {
        if (d.count(1) >= 5 || d.count(2) >= 5 || d.count(3 ) >= 5 ||
                d.count(4) >= 5 || d.count(5) >= 5 || d.count(6) >= 5)
            return 50;
        else
            return 0;
    }
}
