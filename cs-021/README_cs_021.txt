For my final project, I have chosen to build a game that is a close re-creation of the American version of the popular game show Deal or No Deal. For a more detailed explanation of 
the game, visit: https://en.wikipedia.org/wiki/Deal_or_No_Deal

Before gameplay starts, and upon running the program, 26 different dollar values, ranging from $0.01 to $1,000,000, will be placed in 26 different briefcases. 
(This is controlled by the assignment() function.) The money values are as follows:
$0.01
$1
$5
$10
$25
$50
$75
$100
$200
$300
$400
$500
$750
$1,000
$5,000
$10,000
$25,000
$50,000
$75,000
$100,000
$200,000
$300,000
$400,000
$500,000
$750,000
$1,000,000

To begin the game, the user picks a number from 1-26 corresponding to one of the aforementioned briefcases. That case is "put aside" until either the game reaches the final possible 
round or the user chooses to accept the banker's offer (more on that later). 

The game then moves onto the "main" rounds (which are controlled by the case_selection() function. The actions from the beginning of the game are not included in this function because 
case selection in the main rounds are a little different). In the first round, the user picks 6 briefcases to be opened, and are shown the dollar values in each one. Both the case 
number and its corresponding dollar value are removed from their respective lists. This is done 5 times in the second round, 4 in the third, 3 in the fourth, 2 in the fifth, and one in 
each round until just two briefcases (the chosen case from the beginning and one other random case) are left.

At the end of each round, the user is shown which dollar values are still in unopened cases (which ones are still "in play"). The "banker" will make the user an offer to "buy" the case 
they chose at the very beginning of the game (controlled by the banker() fucntion). The banker wants the user to walk away with as little money as possible. I had to do a little bit of 
research for this part of the game, and I found a helpful resource as to how I should make the "banker" behave in this game:
https://towardsdatascience.com/i-figured-out-how-deal-or-no-deal-works-kind-of-875e63a8cef6.
On this page, I found a handy box-and-whisker plot. It has been established that, in the real-life game, the banker's offer is normally a percentage of the expected value (EV) of all 
dollar values that are still in play. As the game progresses, that percentage gets bigger and bigger. To achieve this effect, each time the banker() function is executed, a random value 
between 0 and 1 (I called this p). Depending on what quartile p falls into, and depending on what round the game is in, the offer is a random percentage, between the upper and lower 
bounds of that particular quartile, of the EV. I rounded all offers down to the nearest multiple of $1000, since that's what the banker does in the real game.

If the user accepts the banker's offer, they walk away with that amount. They are shown how much money is in their chosen case. If they do not accept, the game keeps going. If the user 
reaches the final round and still chooses not to accept the banker's offer, they win whatever is in the case they selected at the beginning of the game. (This is all controlled by the 
user_choice() function.)

Basically, regardless of if the user accepts an offer or decides to risk it and see what's in their case, they made a "good" deal if they win more than they would have had they chosen 
the alternative route. This whole game sounds complicated when I try to explain it in words, but the best way to understand it is to just play a few trial rounds.

No pip-installable modules were used in the final product.

With that, I hope you enjoy the game!


* P.S.* I am adding this to the README file years after the completion of this project, but I was playing a few rounds of the game to ensure that I couldn't break it, I was also 
trying to remember the "optimal" strategy for playing. I think I remember it to be the following: keep playing until the banker's offer is greater than or equal to the expected value of 
the dollar value of the briefcase you chose at the beginning of the game. The last game I played, I "cheated" and got out a calculator at the end of each round. I totaled up all the 
available dollar values and divided by the number of remaining cases and compared it each time to the banker's offer. 

Of course, the one time I played this strategy in this short "re-testing" phase I actually had the million dollars in my chosen case (I ended up walking away with $443,000, which is a 
small consolation prize, I suppose). I have such horrible luck. 

Shame on you, Howie Mandel, for popularizing this game just so I could eventually sloppily code it for a class project and constantly lose at it. 

Hopefully the gods of Deal or No Deal smile upon you if you choose to partake. May you walk away from this game with as much imaginary cash as humanly possible.
