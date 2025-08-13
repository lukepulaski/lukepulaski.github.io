public class Threes extends Category {
    public Threes() {
    }

    public int evaluate(Dice d) {
        return 3 * d.count(3);
    }
}
