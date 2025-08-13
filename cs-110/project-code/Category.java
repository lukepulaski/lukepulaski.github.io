/**
 Luke Pulaski
 CS 110

 The Category class is an abstract base class for all categories on the scorecard
 */
public abstract class Category
{
    //instance variables
    private int score; //the current score for the category
    private boolean used; //tells whether the category has been used

    /**
     * Evaluates the Die in the Dice object and returns the scored
     * @param d The ArrayList of Die
     * @return The score in a particular category
     */
    public abstract int evaluate(Dice d);

    /**
     * Adds the value that the Dice would produce to the score
     * and marks the category as used
     * @param d The ArrayList of Die
     */
    public void addValue(Dice d)
    {
        score += evaluate(d);
        used = true;
    }

    /**
     * Accessor method to the score for a particular category
     * @return the score for the category
     */
    public int getScore()
    {
        return score;
    }

    /**
     * Accessor method to whether the category has been used
     * @return true if the category has been used, false otherwise
     */
    public boolean getUsed()
    {
        return used;
    }

}
