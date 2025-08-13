import java.util.ArrayList;
public class Stuff
{
    public static void main(String [] args)
    {
        String s = "[1 2 3 4 5]";
        ArrayList<Integer> array = new ArrayList<Integer>();

        for (int i = 1; i < s.length(); i += 2)
            array.add(Integer.valueOf(s.substring(i, i + 1)));

        for (int i: array)
            System.out.println(i);
    }
}
