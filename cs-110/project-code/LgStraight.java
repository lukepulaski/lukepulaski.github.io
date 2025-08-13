/**
 Luke Pulaski
 CS 110

 The category for Large Straight on the scorecard
 (scores the sum of the values on the Die if all five dice are in
 consecutive numerical order)
 */

public class LgStraight extends Category
{
    public int evaluate(Dice d)
    {
        /**
         * Evaluates the Die in the ArrayList of Die and gives the potential
         * score for the Large Straight category
         * @param d The ArrayList of Die
         * @return The score that would be achieved for the Large Straight category
         */
        int score = 0;

        if (d.contains(2) && d.contains(3) && d.contains(4) && d.contains(5))
        {
            if (d.contains(1) || d.contains(6))
                score = 40;
        }
        return score;
    }
}
