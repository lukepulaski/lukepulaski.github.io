public class Twos extends Category {
    public Twos() {
    }

    public int evaluate(Dice d) {
        return 2 * d.count(2);
    }
}
