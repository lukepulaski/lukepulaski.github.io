import os
import pdfplumber
import pandas as pd
import re


folder_path = '/Users/lukepulaski/Desktop/Tristan Smith Campaign/Lynn Historical Election Results'
outfile = '/Users/lukepulaski/Desktop/Tristan Smith campaign/Lynn Election Data - Raw.xlsx'

month_list = ['JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER']
year_list = [str(year) for year in range(2015, 2026)]
level_list = ['FEDERAL', 'STATE']
phase_list = ['PRIMARY', 'PRELIMINARY', 'SPECIAL']

name_list = []

data_rows = []

def append_rows(attributes, precinct_list, reg_voters, ballots_cast, pct_turnout):
    """
    Purpose: Adds the following data to the list of data rows (which will later be converted to a dataframe) for each precinct in the
    list of precincts: the name of the election, date, year, election level, election phase, precinct, number of registered voters,
    number of ballots cast, and voter turnout.

    Args:
    - attributes (list): Contains the following information: election name, year, election level, election phase, and date (in that order)
    - precinct_list (list): Contains a list of all precincts present in the data sheet
    - reg_voters (list): Contains the number of registered voters for every precinct present in the data sheet
    - ballots_cast (list): Contains the number of ballots cast in every precinct present in the data sheet
    - pct_turnout (list): Contains the voter turnout for every precinct present in the data sheet

    Returns:
    N/A
    
    """
    for precinct, voters, ballots, pct in zip(precinct_list, reg_voters, ballots_cast, pct_turnout):
        data_rows.append({
            'Name' : attributes[0],
            'Date': attributes[4],
            'Year': attributes[1],
            'Level': attributes[2],
            'Phase': attributes[3],
            'Precinct': precinct,
            'Registered Voters': voters,
            'Ballots Cast': ballots,
            'Percent Turnout': pct
            })
    

def amend_precinct_list(length):
    """
    Purpose: The default precinct list contains the 28 precincts and the citywide total for each row in the data sheet. Some data sheets contain
    figures from precincts W1P2A and W4P3A (which were added for the 2023 election cycle), others contain totals given by ward, and others have
    both. This function helps adjust the precinct list for that variability.
    
    Args:
    - length (int): The length that precinct_list should be to accommodate the number of items extracted from a row on the data sheet

    Returns:
    A list of precincts/totals of the appropriate length to fit the length of the data list extracted from the sheet
    
    """
    precinct_list = ['W1P1', 'W1P2', 'W1P3', 'W1P4',
                     'W2P1', 'W2P2', 'W2P3', 'W2P4',
                     'W3P1', 'W3P2', 'W3P3', 'W3P4',
                     'W4P1', 'W4P2', 'W4P3', 'W4P4',
                     'W5P1', 'W5P2', 'W5P3', 'W5P4',
                     'W6P1', 'W6P2', 'W6P3', 'W6P4',
                     'W7P1', 'W7P2', 'W7P3', 'W7P4',
                     'Total']
    
    if length == 31:
        precinct_list.insert(2, 'W1P2A')
        precinct_list.insert(16, 'W4P3A')
    if length == 36:
        precinct_list.insert(4, 'Total W1')
        precinct_list.insert(9, 'Total W2')
        precinct_list.insert(14, 'Total W3')
        precinct_list.insert(19, 'Total W4')
        precinct_list.insert(24, 'Total W5')
        precinct_list.insert(29, 'Total W6')
        precinct_list.insert(34, 'Total W7')
    if length == 38:
        precinct_list.insert(2, 'W1P2A')
        precinct_list.insert(5, 'Total W1')
        precinct_list.insert(10, 'Total W2')
        precinct_list.insert(15, 'Total W3')
        precinct_list.insert(19, 'W4P3A')
        precinct_list.insert(21, 'Total W4')
        precinct_list.insert(26, 'Total W5')
        precinct_list.insert(31, 'Total W6')
        precinct_list.insert(36, 'Total W7')

    return precinct_list


def calc_pct_turnout(reg_voters, ballots_cast):
    """
    Purpose: Calculates voter turnout by dividing the number of ballots cast by a precinct by the number of registered voters

    Args:
    - reg_voters (list): Contains the number of registered voters for every precinct present in the data sheet
    - ballots_cast (list): Contains the number of ballots cast in every precinct present in the data sheet

    Returns:
    A list of the voter turnout of every precinct in the row of the given data sheet.
    
    """
    pct_turnout = []
    for voters, ballots in zip(reg_voters, ballots_cast):
        if voters != 0:
            pct_turnout.append(ballots / voters)
        else:
            pct_turnout.append(0)

    return pct_turnout  
    

def default_clean(attributes, starting_line):
    """
    Purpose: Extracts the lines of the data sheet containing data on registered voters and ballots cast.

    Args:
    - attributes (list): Contains the following information: election name, year, election level, election phase, and date (in that order)
    - starting_line (int): The index of the line where the first row of relevant data appears. For most sheets, line index 2 contains
    data on registered voters, and the line below it contains data on ballots cast.

    Returns:
    N/A
    
    """
    for i in range(starting_line, starting_line + 2):
        lines[i] = lines[i].replace(',', '')
    
    reg_voters = re.findall(r'\d+', lines[starting_line])
    reg_voters = [int(n) for n in reg_voters]

    ballots_cast = re.findall(r'\d+', lines[starting_line + 1])
    ballots_cast = [int(n) for n in ballots_cast]

    pct_turnout = calc_pct_turnout(reg_voters, ballots_cast)

    precinct_list = amend_precinct_list(len(pct_turnout))

    append_rows(attributes, precinct_list, reg_voters, ballots_cast, pct_turnout)


def sticky_digits_clean(attributes, starting_line, clump_indicator):
    """
    Purpose: Extracts the lines of the data sheet containing data on registered voters and ballots cast where some of the data might be "stuck
    together". For example, you might see a clump that looks like '8062401' that should read as '806 2401'.

    Args:
    - attributes (list): Contains the following information: election name, year, election level, election phase, and date (in that order)
    - starting_line (int): The index of the line where the first row of relevant data appears. For most sheets, line index 2 contains
    data on registered voters, and the line below it contains data on ballots cast.
    - clump_indicator (string): Equals 'small' if data lines contain clumps of numbers that are 7 digits long, 'large' for clumps of larger numbers.
    I need to make this distinction because the spacing between digits can vary from sheet to sheet and line to line.

    Returns:
    N/A
    
    """
    reg_voters = []
    ballots_cast = []

    if clump_indicator == 'small':
        reg_voters_raw = [int(n) for n in re.findall(r'\d+', lines[starting_line])]
        ballots_cast_raw = [int(n) for n in re.findall(r'\d+', lines[starting_line + 1])]

        for num in reg_voters_raw:
            num_str = str(num)
            if len(num_str) > 5:
                reg_voters.append(int(num_str[:4]))
                reg_voters.append(int(num_str[4:]))
            else:
                reg_voters.append(num)

        ballots_cast = ballots_cast_raw

    elif clump_indicator == 'large':

        reg_voters_data = re.findall(r'\d+', lines[2])
        ballots_cast_data = re.findall(r'\d+', lines[3])

        for i in range(len(reg_voters_data)):
            if i == 0:
                reg_voters.append(int(reg_voters_data[0][0:4]))
                reg_voters.append(int(reg_voters_data[0][4:8]))
                                
            elif i == 1 or i == 2:
                reg_voters.append(int(reg_voters_data[i][0:3]))
                for j in range(3, len(reg_voters_data[i]), 4):
                    reg_voters.append(int(reg_voters_data[i][j: j + 4]))
            else:
                reg_voters.append(int(reg_voters_data[3]))

        for i in range(len(ballots_cast_data)):
            if len(ballots_cast_data[i]) == 8:
                ballots_cast.append(int(ballots_cast_data[i][0:4]))
                ballots_cast.append(int(ballots_cast_data[i][4:8]))
            elif len(ballots_cast_data[i]) == 7:
                ballots_cast.append(int(ballots_cast_data[i][0:3]))
                ballots_cast.append(int(ballots_cast_data[i][3:7]))
            else:
                ballots_cast.append(int(ballots_cast_data[i]))

    pct_turnout = calc_pct_turnout(reg_voters, ballots_cast)

    precinct_list = amend_precinct_list(len(pct_turnout))

    append_rows(attributes, precinct_list, reg_voters, ballots_cast, pct_turnout)


def pres_primary_clean():
    """
    Purpose: Extracts the lines of the data sheet containing data on registered voters and ballots cast from the 2024 Presidential Preference
    Primary data sheet, which is structured differently than the rest of the tables on the data sheets.

    Args:
    N/A

    Returns:
    A dictionary containing lists of registered voters and ballots cast in each precincts
    
    """
    reg_voters = []
    ballots_cast = []

    adj = 0
    if 'LIBERTARIAN' in lines[5]:
        adj = 2

    lower = 10 + adj
    upper = 41 + adj

    for i in range(lower, upper):

        voting_data = re.sub(r'[^0-9\s]', '', lines[i])
        voting_data = re.findall(r'\d+', voting_data)

        if lower <= i < (upper - 1):
            reg_voters.append(int(voting_data[2]))

            if adj == 2:
                ballots_cast.append(int(voting_data[4]))
            else:
                ballots_cast.append(int(voting_data[4] + voting_data[5]))

        else:
            reg_voters.append(int(voting_data[0] + voting_data[1]))

            if adj == 2:
                ballots_cast.append(int(voting_data[3]))
            else:
                ballots_cast.append(int(voting_data[4] + voting_data[5]))

    return {'Registered Voters': reg_voters,
            'Ballots Cast': ballots_cast}
    

"""
MAIN LOOP

"""
for filename in os.listdir(folder_path):
    
    if filename.lower().endswith('.pdf'):
        
        filepath = os.path.join(folder_path, filename)
        
        with pdfplumber.open(filepath) as pdf:

            if filename == '2024 Presidential Primary - March 5 OFFICIAL.pdf':

                attributes = ['2024 PRESIDENTIAL PREFERENCE PRIMARY; MARCH 5, 2024',
                              '2024', 'FEDERAL', 'PRIMARY', 'MARCH 5, 2024']
                
                name_list.append(name)

                reg_voters = []
                ballots_cast = []
                ballots_cast_d = []
                ballots_cast_r = []
                ballots_cast_l = []
                pct_turnout = []
                
                for i, page in enumerate(pdf.pages, start = 1):
                                 
                    text = page.extract_text().upper()
                    lines = text.split('\n')

                    reg_voters = pres_primary_clean()['Registered Voters']

                    if i == 1:
                        ballots_cast_d = pres_primary_clean()['Ballots Cast']
                    elif i == 2:
                        ballots_cast_r = pres_primary_clean()['Ballots Cast']
                    else:
                        ballots_cast_l = pres_primary_clean()['Ballots Cast']

                for ballots_d, ballots_r, ballots_l in zip(ballots_cast_d, ballots_cast_r, ballots_cast_l):
                    ballots_cast.append(ballots_d + ballots_r + ballots_l)

                pct_turnout = calc_pct_turnout(reg_voters, ballots_cast)

                precinct_list = amend_precinct_list(len(pct_turnout))

                append_rows(attributes, precinct_list, reg_voters, ballots_cast, pct_turnout)

                    
            else:
                
                for page in pdf.pages:
            
                    text = page.extract_text().upper()
                    lines = text.split('\n')

                    description = lines[0]

                    year_found = [year
                                    for year in year_list
                                    if year in description]
                    
                    if year_found:

                        month_pattern = '|'.join(month_list)
                        year_pattern = '|'.join(year_list)
                        date_pattern = rf'\b({month_pattern})\s+\d{{1,2}},\s+({year_pattern})\b'

                        date_found = re.search(date_pattern, description)
                        if date_found:
                            date_found = date_found.group(0)
                                      
                        level_found = [level
                                       for level in level_list
                                       if level in description]
                        if not level_found:
                            level_found = [level
                                           for level in level_list
                                           if level in lines[1]]
                            if not level_found:
                                level_found = ['LOCAL']

                        phase_found = [phase
                                       for phase in phase_list
                                       if phase in description]
                        if not phase_found:
                            phase_found = [phase
                                           for phase in phase_list
                                           if phase in lines[1]]
                            if not phase_found:
                                phase_found = ['GENERAL']

                        name = f'{year_found[0]} {level_found[0]} {phase_found[0]}; {date_found}'

                        attributes = [name, year_found[0], level_found[0], phase_found[0], date_found]

                        if name not in name_list:

                            name_list.append(name)

                            if 'TOTAL REGISTERED VOTERS PER PRECINCT' in lines[4]:

                                default_clean(attributes, 4)

                            elif name == '2022 STATE GENERAL; NOVEMBER 8, 2022':

                                sticky_digits_clean(attributes, 2, 'large')
                                
                            elif name == '2024 STATE GENERAL; NOVEMBER 5, 2024':

                                sticky_digits_clean(attributes, 2, 'small')

                            else:

                                default_clean(attributes, 2)

                                
                            
                        

final_df = pd.DataFrame(data_rows)

final_df = final_df[~final_df['Precinct'].str.contains('Total', case = False, na = False)]
final_df = final_df.sort_values(by = ['Name', 'Precinct'])

if os.path.exists(outfile):
    book = load_workbook(outfile)
    with pd.ExcelWriter(outfile, engine = 'openpyxl', mode = 'a', if_sheet_exists = 'replace') as writer:
        writer._book = book
        final_df.to_excel(writer, sheet_name = 'Election Data', index = False)
else:
    with pd.ExcelWriter(outfile, engine = 'openpyxl', mode = 'w') as writer:
        final_df.to_excel(writer, sheet_name = 'Election Data', index = False)


                        
                        
                        






