# Could the Montreal Expos have been saved?

## Summary

On August 11, 1994, with a record of 74-40, the Montreal Expos were the best team in baseball. Despite having the 
second-lowest payroll in Major League Baseball (MLB), they had managed to assemble a team that was on track to finish 
ahead of baseball's blue-blood franchises in the standings. They were better than the Reds. Better than the Dodgers. 
Better than those good-for-nothing Yankees. Yet none of that mattered, as the Montreal Expos (as well as all other 
MLB teams) had the rest of their 1994 season cancelled due to a players strike. The remaining regular season and playoffs 
were postponed and never played. 

In the offseason leading up to the 1995 season, the Expos let several of their key players from the previous year leave 
in free agency and traded others for very little return. This fire sale, which continued into the following seasons, 
severely depleting the team's talent pool. Their on-field performance never returned to the heights of 1994.

Fast-forward ten years, and the Montreal Expos ceased to exist as a franchise, moving to Washington DC and becoming 
the Nationals. Among other factors, the 1994 players' strike is cited as a primary reason for the team's demise. The 
1994 Expos were already financially in dire straits and had the second-lowest player payroll in all of MLB, and the strike 
only exacerbated those issues. Expos management contended at the time and years afterward that the strike deprived the 
team of additional revenue from regular season and potential playoff games, rendering them unable to sign the players 
let go in the offseason. 

In the following study, I test the validity of the claim that, had the strike never occurred, the Expos would have come up 
with the capital to resign their departing players. First, I will construct a Python program that simulates the remainder of 
the 1994 MLB season. I will repeatedly run this simulation until I find the number of home games the Expos should expect to play 
in the 1994 postseason. Using a combination of the team's real-life regular season attendance figures (which I will extrapolate 
into the playoffs using league-wide playoff attendance trends) as well as ticket price, concession, and parking data, I will 
estimate the Expos' expected revenue from playing the remainder of the 1994 season. An analysis of the Expo's estimated finances 
(estimated revnue and operating cost data) will then either provide evidence for or against the notion that a full 1994 season 
would have allowed them to retain all of their players, keeping the team competitive and maintaining enough fan interest to 
secure a more long-term future for the Expos in Montreal.

## Tasks Completed
- Gathered & cleaned team batting and pitching metrics (Baseball Reference)
- Gathered & cleaned 1994 schedule data and 1994 game log (Retrosheet)
- Wrote Python code to use team batting and ptiching metrics to simulate a game between two teams
