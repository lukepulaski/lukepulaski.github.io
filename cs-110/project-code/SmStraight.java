public class SmStraight extends Category {
    public SmStraight() {
    }

    public int evaluate(Dice d) {
        int score = 0;
        if (d.contains(3) && d.contains(4) && (d.contains(1) && d.contains(2) || d.contains(2) && d.contains(5) || d.contains(5) && d.contains(6))) {
            score = 30;
        }

        return score;
    }
}
