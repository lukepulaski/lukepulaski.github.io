public class ThreeOfAKind extends Category {
    public ThreeOfAKind() {
    }

    public int evaluate(Dice d) {
        return d.count(1) < 3 && d.count(2) < 3 && d.count(3) < 3 && d.count(4) < 3 && d.count(5) < 3 && d.count(6) < 3 ? 0 : d.sum();
    }
}
