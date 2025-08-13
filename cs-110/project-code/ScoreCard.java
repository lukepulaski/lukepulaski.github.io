import java.util.ArrayList;

public class ScoreCard {
    private ArrayList scorecard;
    private int yahtzeeBonus;
    private static int NUM_CATS = 13;

    public ScoreCard() {
        this.scorecard = new ArrayList(NUM_CATS);
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
        this.scorecard.add(ones);
        this.scorecard.add(twos);
        this.scorecard.add(threes);
        this.scorecard.add(fours);
        this.scorecard.add(fives);
        this.scorecard.add(sixes);
        this.scorecard.add(threeOfAKind);
        this.scorecard.add(fourOfAKind);
        this.scorecard.add(fullHouse);
        this.scorecard.add(smStraight);
        this.scorecard.add(lgStraight);
        this.scorecard.add(yahtzee);
        this.scorecard.add(chance);
        this.yahtzeeBonus = 100;
    }

    public void choose(CategoryValue cv, Dice d) {
        Category c = (Category)this.scorecard.get(cv.getValue());
        c.addValue(d);
    }

    public int getEvaluation(CategoryValue cv, Dice d) {
        Category c = (Category)this.scorecard.get(cv.getValue());
        return c.evaluate(d);
    }

    public boolean checkScored(CategoryValue cv) {
        Category c = (Category)this.scorecard.get(cv.getValue());
        return c.getUsed();
    }

    public int getCategoryScore(CategoryValue cv) {
        Category c = (Category)this.scorecard.get(cv.getValue());
        int score = c.getScore();
        if (cv.getValue() == 11 && c.getUsed()) {
            score += this.yahtzeeBonus;
        }

        return score;
    }

    public int scoreTop() {
        int score = 0;

        for(int i = 0; i < 6; ++i) {
            score += ((Category)this.scorecard.get(i)).getScore();
        }

        if (score >= 63) {
            score += 35;
        }

        return score;
    }

    public int scoreBottom() {
        int score = 0;

        for(int i = 6; i < 13; ++i) {
            score += ((Category)this.scorecard.get(i)).getScore();
        }

        return score;
    }

    public int score() {
        return this.scoreTop() + this.scoreBottom();
    }

    public String toString() {
        String var10000 = String.format("Current Scorecard:\n");
        return var10000 + String.format("%21s", String.format("Ones: %d\n", ((Category)this.scorecard.get(0)).getScore())) + String.format("%21s", String.format("Twos: %d\n", ((Category)this.scorecard.get(1)).getScore())) + String.format("%21s", String.format("Threes: %d\n", ((Category)this.scorecard.get(2)).getScore())) + String.format("%21s", String.format("Fours: %d\n", ((Category)this.scorecard.get(3)).getScore())) + String.format("%21s", String.format("Fives: %d\n", ((Category)this.scorecard.get(4)).getScore())) + String.format("%21s", String.format("Sixes: %d\n", ((Category)this.scorecard.get(5)).getScore())) + String.format("%21s", String.format("Three of a Kind: %d\n", ((Category)this.scorecard.get(6)).getScore())) + String.format("%21s", String.format("Four of a Kind: %d\n", ((Category)this.scorecard.get(7)).getScore())) + String.format("%21s", String.format("Full House: %d\n", ((Category)this.scorecard.get(8)).getScore())) + String.format("%21s", String.format("Small Straight: %d\n", ((Category)this.scorecard.get(9)).getScore())) + String.format("%21s", String.format("Large Straight: %d\n", ((Category)this.scorecard.get(10)).getScore())) + String.format("%21s", String.format("Yahtzee: %d\n", ((Category)this.scorecard.get(11)).getScore())) + String.format("%21s", String.format("Chance: %d\n", ((Category)this.scorecard.get(12)).getScore())) + String.format("%21s", String.format("UPPER TOTAL: %d\n", this.scoreTop())) + String.format("%21s", String.format("LOWER TOTAL: %d\n", this.scoreBottom())) + String.format("%21s", String.format("TOTAL: %d\n", this.score()));
    }
}
