"""
Luke Pulaski
CS 021
Final Project - Deal or No Deal
"""

import random

with open('README_cs_021.txt') as f:
    for line in f: 
        print(line)

def assignment(lst):
    """
    This function assigns different 26 dollar values
    (from $0.01 to $1 million) to 26 different briefcases.
    
    To find the dollar values, see the list money_values
    on line 228.
    """
    random.shuffle(lst)
    for n in range(1, 27):
        briefcases[n] = lst[n - 1]
    return briefcases

def case_selection(rnd):
    """
    This function asks the user to pick a number corresponding
    to a briefcase, and reveals the dollar value inside that case.
    It then takes the case number and dollar value out of play.
    """
    while True:
        try:
            choice = int(input('Pick a case: '))
            if choice < 1 or choice > 26:   
                print('That is not a valid number. Try again!')
            elif rnd != 0:
                if choice not in case_numbers:
                    print(f'You have already selected Case #{choice}. Try again!')
                else:
                    case_numbers.remove(choice)
                    print(f'There is ${briefcases[choice]:,} in Case #{choice}.')
                    money_values.remove(briefcases[choice])
                    break
            else:
                case_numbers.remove(choice)
                break               
        except ValueError:   
            print('That is not a valid input. Try again!')
    return choice     

def banker(rnd):
    """
    This function behaves like the banker in the real-life
    game show. The banker's offer at the end of each round
    is a percentage of the expected value of the dollar values
    left in play. That percentage is a random percentage based
    on data about how the banker on real-life Deal or No Deal
    game behaves.
    """
    p = random.random()
    ev = sum(money_values) / len(money_values) + 1
    if rnd == 1:
        if p <= 0.25:
            lower = 5
            upper = 12
        elif p <= 0.5:
            lower = 13
            upper = 16
        elif p <= 0.75:
            lower = 17
            upper = 21
        else:
            lower = 22
            upper = 37
    elif rnd == 2:
        if p <= 0.25:
            lower = 10
            upper = 23
        elif p <= 0.5:
            lower = 24
            upper = 27
        elif p <= 0.75:
            lower = 28
            upper = 36
        else:
            lower = 37
            upper = 55
    elif rnd == 3:
        if p <= 0.25:
            lower = 15
            upper = 32
        elif p <= 0.5:
            lower = 33
            upper = 37
        elif p <= 0.75:
            lower = 38
            upper = 48
        else:
            lower = 49
            upper = 72
    elif rnd == 4:
        if p <= 0.25:
            lower = 30
            upper = 43
        elif p <= 0.5:
            lower = 44
            upper = 51
        elif p <= 0.75:
            lower = 52
            upper = 68
        else:
            lower = 69
            upper = 97
    elif rnd == 5:
        if p <= 0.25:
            lower = 31
            upper = 53
        elif p <= 0.5:
            lower = 54
            upper = 67
        elif p <= 0.75:
            lower = 68
            upper = 78
        else:
            lower = 79
            upper = 100
    elif rnd == 6:
        if p <= 0.25:
            lower = 42
            upper = 68
        elif p <= 0.5:
            lower = 69
            upper = 77
        elif p <= 0.75:
            lower = 78
            upper = 86
        else:
            lower = 87
            upper = 111
    elif rnd == 7:
        if p <= 0.25:
            lower = 58
            upper = 81
        elif p <= 0.5:
            lower = 82
            upper = 91
        elif p <= 0.75:
            lower = 92
            upper = 99
        else:
            lower = 100
            upper = 113
    elif rnd == 8:
        if p <= 0.25:
            lower = 70
            upper = 89
        elif p <= 0.5:
            lower = 90
            upper = 100
        elif p <= 0.75:
            lower = 101
            upper = 108
        else:
            lower = 109
            upper = 120
    else:
        if p <= 0.25:
            lower = 89
            upper = 98
        elif p <= 0.5:
            lower = 99
            upper = 104
        elif p <= 0.75:
            lower = 105
            upper = 110
        else:
            lower = 111
            upper = 125
    offer = (ev * (random.randint(lower, upper) / 100)) // 1000 * 1000
    if offer == 0:
        return 1000
    else:
        return offer

def user_choice(rnd, case, offer):
    """
    This function either reveals whether or not the user "won" if
    they accept the offer or if it is the final round, otherwise it
    keeps the game moving to the next round. The round number is taken
    as an argument because, as mentioned, the function behaves
    differently if the game is in the final round.
    """
    while True:
        response = input('Would you like to accept? '
                         'Press Y for yes and N for no: ').lower()
        if response == 'y':
            print(f'\nYou have won ${offer:,.0f}.\n'
                  f'\nThere was ${briefcases[case]:,} in Case #{case}, '
                  'the case you chose at the beginning of the game.\n')
            if offer >= briefcases[case]:
                print('You made a good deal!\n')
            else:
                print("You didn't make such a good deal.\n")
            print('Thanks for playing!')
            exit()
        elif response == 'n':
            if rnd == 10:
                print(f'You have won ${briefcases[case]:,}.\n')
                if offer <= briefcases[case]:
                    print('You made a good deal!\n')
                else:
                    print("You didn't make such a good deal.\n")
                print('Thanks for playing!')
                exit()
            else:
                print("\nLet's move onto the next round!\n")
            break
        else:
            print('\nThat is not a valid response. Try again!\n')

if __name__ == '__main__':
    
    case_numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13,
                    14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24,
                    25, 26]
    
    money_values = [0.01, 1, 5, 10, 25, 50, 75,
                    100, 200, 300, 400, 500, 750,
                    1000, 5000, 10000, 25000, 50000,
                    75000, 100000, 200000, 300000,
                    400000, 500000, 750000, 1000000]
    
    briefcases = {}
    
    assignment(money_values)
    money_values.sort()
    
    print('Of Cases 1-26, please select the case that you think contains $1,000,000: ')
    special_case = case_selection(0)
    print(f'You have chosen Case #{special_case}. This will not '
          'be opened until the final round of the game, '
          'whenever that should be.\n')
    
    for n in range(1, 11):
        print(f'Available cases:\n{case_numbers}')
        if n == 1:
            print('Of the above, please open 6 briefcases.')
            for z in range(6):
                case_selection(n)
        elif n == 2:
            print('Of the above, please open 5 more briefcases.')
            for z in range(5):
                case_selection(n)
        elif n == 3:
            print('Of the above, please open 4 more briefcases.')
            for z in range(4):
                case_selection(n)
        elif n == 4:
            print('Of the above, please open 3 more briefcases.')
            for z in range(3):
                case_selection(n)
        elif n == 5:
            print('Of the above, please open 2 more briefcases.')
            for z in range(2):
                case_selection(n)
        else:   
            if n == 10:
                print('You have made it to the final round! Only two cases remain: '
                        f'Case #{case_numbers[0]} and Case #{special_case}, '
                        'the case you selected at the beginning of the game.\n'
                        'The banker will make you one last offer to buy your case. '
                        'If you accept, you win whatever amount is offered to you. '
                        f'If you do not, you win whatever is in Case #{special_case}.')
            else:
                print('Of the above, please open another briefcase.')
                case_selection(n)
                
        print(f'\nMoney values left:')
        
        for value in money_values:
            print(f'${value:,}')
            
        banker_offer = banker(n)
        
        print(f"\nThe banker's offer to buy your chosen case is ${banker_offer:,.0f}.\n")
        
        user_choice(n, special_case, banker_offer)
    
