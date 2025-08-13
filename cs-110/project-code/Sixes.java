public class Sixes extends Category {
    public Sixes() {
    }

    public int evaluate(Dice d) {
        return 6 * d.count(6);
    }
}
