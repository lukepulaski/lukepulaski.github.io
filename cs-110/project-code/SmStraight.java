/**
 Luke Pulaski
 CS 110

 The category for Small Straight on the scorecard
 (scores the sum of the values on the Die if four of the dice are in
 consecutive numerical order)
 */

public class SmStraight extends Category
{
    /**
     * Evaluates the Die in the ArrayList of Die and gives the potential
     * score for the Small Straight category
     * @param d The ArrayList of Die
     * @return The score that would be achieved for the Small Straight category
     */
    public int evaluate(Dice d)
    {
        int score = 0;

        if (d.contains(3) && d.contains(4))
        {
            if ((d.contains(1) && d.contains(2)) ||
                    (d.contains(2) && d.contains(5)) ||
                    (d.contains(5) && d.contains(6)))
                score = 30;
        }
        return score;
    }
}
