/**
 Luke Pulaski
 CS 110

 The ScoreCard class is the collection of categories as well as the scores of
 the top/bottom and total
 */

import java.util.ArrayList;
public class ScoreCard
{
    //instance variables
    private ArrayList scorecard; //collection of Category objects
    private int yahtzeeBonus; //additional score for each Yahtzee beyond the first

    //class constant
    private static int NUM_CATS = 13; //total number of categories

    /**
     * Constructor creates all Category objects and adds them to the ArrayList
     */
    public ScoreCard()
    {
        scorecard = new ArrayList<Category>(NUM_CATS);

        Category ones = new Ones();
        Category twos = new Twos();
        Category threes = new Threes();
        Category fours = new Fours();
        Category fives = new Fives();
        Category sixes = new Sixes();
        Category threeOfAKind = new ThreeOfAKind();
        Category fourOfAKind = new FourOfAKind();
        Category yahtzee = new FiveOfAKind();
        Category smStraight = new SmStraight();
        Category lgStraight = new LgStraight();
        Category fullHouse = new FullHouse();
        Category chance = new Chance();

        scorecard.add(ones);
        scorecard.add(twos);
        scorecard.add(threes);
        scorecard.add(fours);
        scorecard.add(fives);
        scorecard.add(sixes);
        scorecard.add(threeOfAKind);
        scorecard.add(fourOfAKind);
        scorecard.add(fullHouse);
        scorecard.add(smStraight);
        scorecard.add(lgStraight);
        scorecard.add(yahtzee);
        scorecard.add(chance);

        yahtzeeBonus = 100;
    }

    /**
     * Uses the category value to get the appropriate Category
     * and scores that category, then indicates that it has been used
     * @param cv The category value of the category
     * @param d The ArrayList of Die
     */
    public void choose(CategoryValue cv, Dice d)
    {
        Category c = (Category)scorecard.get(cv.getValue());
        c.addValue(d);
    }

    /**
     * Gives the score that would be achieved in a certain category
     * @param cv The category value of the category
     * @param d The ArrayList of Die
     * @return the potential score for the category
     */
    public int getEvaluation(CategoryValue cv, Dice d)
    {
        Category c = (Category)scorecard.get(cv.getValue());
        return c.evaluate(d);
    }

    /**
     * Determines whether the category has been used
     * @param cv The category value for the category
     * @return
     */
    public boolean checkScored(CategoryValue cv)
    {
        Category c = (Category)scorecard.get(cv.getValue());
        if (c.getUsed())
            return true;
        else
            return false;
    }

    /**
     * Gives the score for the specified category
     * @param cv The category value for the category
     * @return The score for the specified category
     */
    public int getCategoryScore(CategoryValue cv)
    {
        Category c = (Category)scorecard.get(cv.getValue());
        int score = c.getScore();
        if (cv.getValue() == 11 && c.getUsed())
            score += yahtzeeBonus;
        return score;
    }

    /**
     * Gives the score for the top of the scorecard
     * @return The score for the top of the scorecard
     */
    public int scoreTop()
    {
        int score = 0;
        for (int i = 0; i < 6; i++)
            score += ((Category)scorecard.get(i)).getScore();
        if (score >= 63)
            score += 35;
        return score;
    }

    /**
     * Gives the score for the bottom of the scorecard
     * @return The score for the bottom of the scorecard
     */
    public int scoreBottom()
    {
        int score = 0;
        for (int i = 6; i < 13; i++)
            score += ((Category)scorecard.get(i)).getScore();
        return score;
    }

    /**
     * Gives the total score for the scorecard by totaling the top and bottom totals
     * @return The total score for the scorecard
     */
    public int score()
    {
        return scoreTop() + scoreBottom();
    }

    /**
     * Converts the scorecard (which includes all categories and totals) to a String
     * @return The String form of the scorecard
     */
    @Override
    public String toString()
    {
        return String.format("Current Scorecard:\n") +
                String.format("%21s", String.format("Ones: %d\n", ((Category)scorecard.get(0)).getScore())) +
                String.format("%21s", String.format("Twos: %d\n", ((Category)scorecard.get(1)).getScore())) +
                String.format("%21s", String.format("Threes: %d\n", ((Category)scorecard.get(2)).getScore())) +
                String.format("%21s", String.format("Fours: %d\n", ((Category)scorecard.get(3)).getScore())) +
                String.format("%21s", String.format("Fives: %d\n", ((Category)scorecard.get(4)).getScore())) +
                String.format("%21s", String.format("Sixes: %d\n", ((Category)scorecard.get(5)).getScore())) +
                String.format("%21s", String.format("Three of a Kind: %d\n", ((Category)scorecard.get(6)).getScore())) +
                String.format("%21s", String.format("Four of a Kind: %d\n", ((Category)scorecard.get(7)).getScore())) +
                String.format("%21s", String.format("Full House: %d\n", ((Category)scorecard.get(8)).getScore())) +
                String.format("%21s", String.format("Small Straight: %d\n", ((Category)scorecard.get(9)).getScore())) +
                String.format("%21s", String.format("Large Straight: %d\n", ((Category)scorecard.get(10)).getScore())) +
                String.format("%21s", String.format("Yahtzee: %d\n", ((Category)scorecard.get(11)).getScore())) +
                String.format("%21s", String.format("Chance: %d\n", ((Category)scorecard.get(12)).getScore())) +
                String.format("%21s", String.format("UPPER TOTAL: %d\n", scoreTop())) +
                String.format("%21s", String.format("LOWER TOTAL: %d\n", scoreBottom())) +
                String.format("%21s", String.format("TOTAL: %d\n", score()));
    }

}
