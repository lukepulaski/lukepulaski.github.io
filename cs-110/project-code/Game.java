/**
 Luke Pulaski
 CS 110

 The Game class is responsible for playing the game
 */

import java.util.Scanner;
import java.util.Arrays;
public class Game
{
    /**
     * Kicks off the game and conducts all of its steps
     */
    public void playGame()
    {
        //"Welcome to Yahtzee" intro
        System.out.println("*******************************************************");
        System.out.println(String.format("%36s", "WELCOME TO YAHTZEE"));
        System.out.println("*******************************************************\n");

        //creates two scorecards
        ScoreCard player1 = new ScoreCard();
        ScoreCard player2 = new ScoreCard();

        //creates user input Scanner
        Scanner keyboard = new Scanner(System.in);

        //creates dice ArrayLists
            //dice = main Dice list
            //save = saved Dice list
        DiceRoll dice = new DiceRoll();
        Dice save = new Dice();

        //creates 5 Die and adds them to dice ArrayList
        Die d1 = new Die();
        Die d2 = new Die();
        Die d3 = new Die();
        Die d4 = new Die();
        Die d5 = new Die();
        dice.addDie(d1);
        dice.addDie(d2);
        dice.addDie(d3);
        dice.addDie(d4);
        dice.addDie(d5);

        //MAIN GAME LOOP
        //each player gets 13 total turns
        for (int turn = 1; turn <= 26; turn++)
        {
            //decides if it is currently Player 1 or Player 2's turn
            if (turn % 2 == 1)
            {
                System.out.println("Player 1");
                System.out.println(player1);

                System.out.println("Dice to reroll:");
                System.out.println(dice);

                boolean turnOver = false;
                int numRollsLeft = 2;
                while (!turnOver)
                {
                    String choice = savedDieInputChecker(keyboard, save);
                    if (choice.equals("roll"))
                    {
                        dice.toss();

                        System.out.println("Dice to reroll:");
                        System.out.println(dice);
                        System.out.println("Dice to save:");
                        System.out.println(save);

                        numRollsLeft--;
                        if (numRollsLeft == 0)
                        {
                            for (int i = save.getNumDice() - 1; i >= 0; i--)
                            {
                                dice.addDie(save.getDie(i));
                                save.removeDie(i);
                            }
                            System.out.println("Final roll:");
                            System.out.println(dice + "\n");
                            score(keyboard, player1, dice);
                            turnOver = true;
                        }
                    }
                    else if (choice.equals("score"))
                    {
                        for (int i = save.getNumDice() - 1; i >= 0; i--)
                        {
                            dice.addDie(save.getDie(i));
                            save.removeDie(i);
                        }
                        score(keyboard, player1, dice);
                        turnOver = true;
                    }
                    else
                    {
                        saveDie(choice, dice, save);

                        System.out.println("Dice to reroll:");
                        System.out.println(dice);
                        System.out.println("Dice to save:");
                        System.out.println(save);
                    }
                }

                for (int i = 0; i < save.getNumDice(); i++)
                    dice.addDie(save.getDie(i));
                dice.toss();

                System.out.println("\n******************************************************\n");
            }
            else
            {
                System.out.println("Player 2");
                System.out.println(player2);

                System.out.println("Dice to reroll:");
                System.out.println(dice);

                boolean turnOver = false;
                int numRollsLeft = 2;
                while (!turnOver)
                {
                    String choice = savedDieInputChecker(keyboard, save);
                    if (choice.equals("roll"))
                    {
                        dice.toss();

                        System.out.println("Dice to reroll:");
                        System.out.println(dice);
                        System.out.println("Dice to save:");
                        System.out.println(save);

                        numRollsLeft--;
                        if (numRollsLeft == 0)
                        {
                            for (int i = save.getNumDice() - 1; i >= 0; i--)
                            {
                                dice.addDie(save.getDie(i));
                                save.removeDie(i);
                            }
                            System.out.println("Final roll:");
                            System.out.println(dice + "\n");
                            score(keyboard, player2, dice);
                            turnOver = true;
                        }
                    }
                    else if (choice.equals("score"))
                    {
                        for (int i = save.getNumDice() - 1; i >= 0; i--)
                        {
                            dice.addDie(save.getDie(i));
                            save.removeDie(i);
                        }
                        score(keyboard, player2, dice);
                        turnOver = true;
                    }
                    else
                    {
                        saveDie(choice, dice, save);

                        System.out.println("Dice to reroll:");
                        System.out.println(dice);
                        System.out.println("Dice to save:");
                        System.out.println(save);
                    }
                }

                for (int i = 0; i < save.getNumDice(); i++)
                    dice.addDie(save.getDie(i));
                dice.toss();

                System.out.println("\n******************************************************\n");
            }

        }
        System.out.println(String.format("Player 1 final score: %d", player1.score()));
        System.out.println(String.format("Player 2 final score: %d", player2.score()));
        if (player1.score() > player2.score())
            System.out.println("Player 1 wins!");
        else if (player1.score() < player2.score())
            System.out.println("Player 2 wins!");
        else
            System.out.println("It's a tie!");
    }

    /**
     * Handles the following user input exceptions:
     *  1. If the user enters the values without [ ]
     *  2. If the user doesn't put spaces between the values
     *  3. If the user enters a value other than 1, 2, 3, 4, or 5
     *  4. If the user enters the same value twice or more
     * @param keyboard The Scanner for user input
     * @param save The ArrayList of saved Die objects
     */
    public String savedDieInputChecker(Scanner keyboard, Dice save)
    {
        System.out.println("Save dice with [ ] filled with index values separated by spaces\n" +
                "'roll' to reroll, 'score' to score");
        String userChoice = keyboard.nextLine();

        if (userChoice.toLowerCase().equals("roll"))
            return "roll";
        else if (userChoice.toLowerCase().equals("score"))
            return "score";
        else
        {
            if (userChoice.charAt(0) != '[' && userChoice.charAt(userChoice.length() - 1) != ']')
            {
                System.out.println("Please put brackets ([ ]) around the indices of the dice you want to save.");
                return savedDieInputChecker(keyboard, save);
            }
            else if (checkSpaces(userChoice))
            {
                System.out.println("Please make sure to put spaces between the values.");
                return savedDieInputChecker(keyboard, save);
            }
            else if (checkIndices(userChoice))
            {
                System.out.println("Please enter indices 1, 2, 3, 4, or 5.");
                return savedDieInputChecker(keyboard, save);
            }
            else if (checkUniqueIndices(userChoice))
            {
                System.out.println("It seems that you are saving the same die more than once. Please try again.");
                return savedDieInputChecker(keyboard, save);
            }
            return userChoice;
        }
    }

    /**
     * Checks if there are spaces between all the user input values
     * @param s The user input values in the form of a String
     * @return true if there is at least 1 space missing, false otherwise
     */
    public boolean checkSpaces(String s)
    {
        s = s.substring(1, s.length() - 1);
        int numSpacesMissing = 0;
        for (int i = 1; i < s.length(); i += 2)
        {
            if (!String.valueOf(s.charAt(i)).equals(" "))
                numSpacesMissing++;
        }

        if (numSpacesMissing > 0)
            return true;
        else
            return false;
    }

    /**
     * Checks if all the user input values are either 1, 2, 3, 4, or 5.
     * Also checks if the user has entered a non-integer value.
     * @param s The user input values in the form of a String
     * @return true if there is at least 1 value that is not the
     * String form of an integer between 1 and 5, false otherwise
     */
    public boolean checkIndices(String s)
    {
        s = s.substring(1, s.length() - 1);
        s = s.replace(" ","");

        int numIndexOutOfBounds = 0;
        for (int i = 0; i < s.length(); i++)
        {
            if (!String.valueOf(s.charAt(i)).equals("1") &&
                    !String.valueOf(s.charAt(i)).equals("2") &&
                    !String.valueOf(s.charAt(i)).equals("3") &&
                    !String.valueOf(s.charAt(i)).equals("4") &&
                    !String.valueOf(s.charAt(i)).equals("5"))
                numIndexOutOfBounds++;
        }

        if (numIndexOutOfBounds > 0)
            return true;
        else
            return false;
    }

    /**
     * Checks if all the user input values are unique (i.e. no repeated values)
     * @param s The user input values in the form of a String
     * @return true if there is at least 1 instance of repeated values, false otherwise
     */
    public boolean checkUniqueIndices(String s)
    {
        s = s.substring(1, s.length() - 1);
        s = s.replace(" ","");

        int ones = 0;
        int twos = 0;
        int threes = 0;
        int fours = 0;
        int fives = 0;
        for (int i = 0; i < s.length(); i++)
        {
            if (String.valueOf(s.charAt(i)).equals("1"))
                ones++;
            else if (String.valueOf(s.charAt(i)).equals("2"))
                twos++;
            else if (String.valueOf(s.charAt(i)).equals("3"))
                threes++;
            else if (String.valueOf(s.charAt(i)).equals("4"))
                fours++;
            else
                fives++;
        }

        if ((ones > 1) || (twos > 1) || (threes > 1) || (fours > 1) || (fives > 1))
            return true;
        else
            return false;
    }

    /**
     * Takes the user input index values, converts them to integers, then saves the Die
     * at the given index values in the main ArrayList of Die
     * @param s The user input index values in the form of a String
     * @param dice The main ArrayList of Die
     * @param save The ArrayList of Die to be filled with Die to be saved
     */
    public void saveDie(String s, DiceRoll dice, Dice save)
    {
        s = s.substring(1, s.length() - 1);
        s = s.replace(" ","");

        //sorts index values in ascending order
        char[] indices= s.toCharArray();
        Arrays.sort(indices);

        //takes each index and saves each Die at that index
        //takes each index and removes the Die from the main ArrayList at that index
        for (int i = s.length() - 1; i >= 0; i--)
        {
            int index = Integer.valueOf(String.valueOf(indices[i])) - 1;
            save.addDie(dice.getDie(index));
            dice.removeDie(index);
        }
    }

    /**
     * Handles the following exceptions:
     *  1. If the user enters a non-integer value
     *  2. If the user enters an integer not between 1 and 13
     * @param keyboard The Scanner for user input
     * @param scorecard The specified scorecard (Player 1's or Player 2's)
     * @param dice The main ArrayList of Die
     * @return The String form of the value corresponding to the category the player
     * wishes to score
     */
    public String scoreInputValueChecker(Scanner keyboard, ScoreCard scorecard, DiceRoll dice)
    {
        String userChoice = keyboard.nextLine();

        if (!userChoice.equals("1") && !userChoice.equals("2") && !userChoice.equals("3") &&
                !userChoice.equals("4") && !userChoice.equals("5") && !userChoice.equals("6") &&
                !userChoice.equals("7") && !userChoice.equals("8") && !userChoice.equals("9") &&
                !userChoice.equals("10") && !userChoice.equals("11") && !userChoice.equals("12") &&
                !userChoice.equals("13"))
        {
            System.out.println("Please enter a number between 1 and 13.");
             return scoreInputValueChecker(keyboard, scorecard, dice);
        }
        return userChoice;
    }

    /**
     * Handles the following exceptions:
     *  1. If the user has already scored in the category they wish to score
     * @param keyboard The Scanner for user input
     * @param scorecard The specified scorecard (Player 1's or Player 2's)
     * @param dice The main ArrayList of Die
     * @return The category value of the category the user wishes to score
     */
    public CategoryValue scoreInputChecker(Scanner keyboard, ScoreCard scorecard, DiceRoll dice)
    {
        String userChoice = scoreInputValueChecker(keyboard, scorecard, dice);
        CategoryValue cv;
        if (userChoice.equals("1")) {
            cv = CategoryValue.ONES;
            if (scorecard.checkScored(cv))
            {
                System.out.println("You have already scored in this category. Try again!");
                return scoreInputChecker(keyboard, scorecard, dice);
            }
        }
        else if (userChoice.equals("2")) {
            cv = CategoryValue.TWOS;
            if (scorecard.checkScored(cv))
            {
                System.out.println("You have already scored in this category. Try again!");
                return scoreInputChecker(keyboard, scorecard, dice);
            }
        }
        else if (userChoice.equals("3")) {
            cv = CategoryValue.THREES;
            if (scorecard.checkScored(cv))
            {
                System.out.println("You have already scored in this category. Try again!");
                return scoreInputChecker(keyboard, scorecard, dice);
            }
        }
        else if (userChoice.equals("4")) {
            cv = CategoryValue.FOURS;
            if (scorecard.checkScored(cv))
            {
                System.out.println("You have already scored in this category. Try again!");
                return scoreInputChecker(keyboard, scorecard, dice);
            }
        }
        else if (userChoice.equals("5")) {
            cv = CategoryValue.FIVES;
            if (scorecard.checkScored(cv))
            {
                System.out.println("You have already scored in this category. Try again!");
                return scoreInputChecker(keyboard, scorecard, dice);
            }
        }
        else if (userChoice.equals("6")) {
            cv = CategoryValue.SIXES;
            if (scorecard.checkScored(cv))
            {
                System.out.println("You have already scored in this category. Try again!");
                return scoreInputChecker(keyboard, scorecard, dice);
            }
        }
        else if (userChoice.equals("7")) {
            cv = CategoryValue.THREE_OF_A_KIND;
            if (scorecard.checkScored(cv))
            {
                System.out.println("You have already scored in this category. Try again!");
                return scoreInputChecker(keyboard, scorecard, dice);
            }
        }
        else if (userChoice.equals("8")) {
            cv = CategoryValue.FOUR_OF_A_KIND;
            if (scorecard.checkScored(cv))
            {
                System.out.println("You have already scored in this category. Try again!");
                return scoreInputChecker(keyboard, scorecard, dice);
            }
        }
        else if (userChoice.equals("9")) {
            cv = CategoryValue.FULL_HOUSE;
            if (scorecard.checkScored(cv))
            {
                System.out.println("You have already scored in this category. Try again!");
                return scoreInputChecker(keyboard, scorecard, dice);
            }
        }
        else if (userChoice.equals("10")) {
            cv = CategoryValue.SM_STRAIGHT;
            if (scorecard.checkScored(cv))
            {
                System.out.println("You have already scored in this category. Try again!");
                return scoreInputChecker(keyboard, scorecard, dice);
            }
        }
        else if (userChoice.equals("11")) {
            cv = CategoryValue.LG_STRAIGHT;
            if (scorecard.checkScored(cv))
            {
                System.out.println("You have already scored in this category. Try again!");
                return scoreInputChecker(keyboard, scorecard, dice);
            }
        }
        else if (userChoice.equals("12")) {
            cv = CategoryValue.YAHTZEE;
            if (scorecard.checkScored(cv))
            {
                return scoreInputChecker(keyboard, scorecard, dice);
            }
        }
        else {
            cv = CategoryValue.CHANCE;
            if (scorecard.checkScored(cv))
            {
                System.out.println("You have already scored in this category. Try again!");
                return scoreInputChecker(keyboard, scorecard, dice);
            }
        }
        return cv;
    }

    /**
     * Scores the category the user wishes to score
     * @param keyboard The Scanner for user input
     * @param scorecard The specified scorecard (Player 1's or Player 2's)
     * @param dice The main ArrayList of Die
     */
    public void score(Scanner keyboard, ScoreCard scorecard, DiceRoll dice)
    {
        System.out.println("Select a category you have not scored in yet:");
        System.out.println(getEvaluations(scorecard, dice));
        CategoryValue cv = scoreInputChecker(keyboard, scorecard, dice);
        System.out.println(String.format("You scored %d points in %s.", scorecard.getEvaluation(cv, dice), cv));
        scorecard.choose(cv, dice);
    }

    /**
     * Formats the evaluations for all categories as a String
     * @param scorecard The specified scorecard (Player 1's or Player 2's)
     * @param dice The main ArrayList of Die
     * @return the evaluations for all categories as a String
     */
    public String getEvaluations(ScoreCard scorecard, DiceRoll dice)
    {
        return String.format("1. Ones: %d\n", scorecard.getEvaluation(CategoryValue.ONES, dice)) +
                String.format("2. Twos: %d\n", scorecard.getEvaluation(CategoryValue.TWOS, dice)) +
                String.format("3. Threes: %d\n", scorecard.getEvaluation(CategoryValue.THREES, dice)) +
                String.format("4. Fours: %d\n", scorecard.getEvaluation(CategoryValue.FOURS, dice)) +
                String.format("5. Fives: %d\n", scorecard.getEvaluation(CategoryValue.FIVES, dice)) +
                String.format("6. Sixes: %d\n", scorecard.getEvaluation(CategoryValue.SIXES, dice)) +
                String.format("7. Three of a Kind: %d\n", scorecard.getEvaluation(CategoryValue.THREE_OF_A_KIND, dice)) +
                String.format("8. Four of a Kind: %d\n", scorecard.getEvaluation(CategoryValue.FOUR_OF_A_KIND, dice)) +
                String.format("9. Full House: %d\n", scorecard.getEvaluation(CategoryValue.FULL_HOUSE, dice)) +
                String.format("10. Small Straight: %d\n", scorecard.getEvaluation(CategoryValue.SM_STRAIGHT, dice)) +
                String.format("11. Large Straight: %d\n", scorecard.getEvaluation(CategoryValue.LG_STRAIGHT, dice)) +
                String.format("12. Yahtzee: %d\n", scorecard.getEvaluation(CategoryValue.YAHTZEE, dice)) +
                String.format("13. Chance: %d", scorecard.getEvaluation(CategoryValue.CHANCE, dice));
    }

}
