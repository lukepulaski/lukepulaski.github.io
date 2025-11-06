from openpyxl import load_workbook
import os
import pdfplumber
import pandas as pd
import re


folder_path = '/Users/lukepulaski/Desktop/Tristan Smith Campaign/Lynn Historical Election Results'
outfile = '/Users/lukepulaski/Desktop/Tristan Smith campaign/Lynn Election Data - Raw.xlsx'

month_list = ['JANUARY', 'FEBRUARY', 'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', 'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER']
year_list = [str(year) for year in range(2015, 2026)]

name_list = []

data_rows = []

def append_rows(attributes, precinct_list, ballots_received):
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
    for precinct, ballots in zip(precinct_list, ballots_received):
        row = {
            'Name' : attributes[0],
            'Year': attributes[1],
            'Phase': attributes[3],
            'Candidate': attributes[4],
            'Precinct': precinct,
            'Ballots Received': ballots,
            'Place on Ballot': attributes[5]
            }
        data_rows.append(row)
        
        

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


def get_ballots_received(line):
    """
    Purpose: Extracts the lines of the data sheet containing data on the number of ballots received for each candidate.

    Args:
    - line (list): Contains the number of ballots received for each candidates

    Returns:
    A list of the number of ballots received by precinct
    
    """
    ballots_received = re.findall(r'\d+', line)
    ballots_received = [int(n) for n in ballots_received]

    return ballots_received


"""
MAIN LOOP

"""
for filename in os.listdir(folder_path):
    
    if filename.lower().endswith('.pdf'):
        
        filepath = os.path.join(folder_path, filename)
        
        with pdfplumber.open(filepath) as pdf:

            for page in pdf.pages:
            
                text = page.extract_text().upper()
                lines = text.split('\n')

                description = lines[0]
                
                year_found = [year
                                for year in year_list
                                if year in description]

                if year_found:

                    if 'LOCAL' in description:
                        level_found = 'LOCAL'

                        phase_found = 'GENERAL'
                        if 'PRELIMINARY' in description:
                            phase_found = 'PRELIMINARY'

                        name = f'{year_found[0]} {level_found} {phase_found}'

                        attributes = [name, year_found[0], level_found, phase_found]

                        if name not in name_list:

                            name_list.append(name)

                            place = 1
                            for line in lines:

                                if 'SCHOOL COMMITTEE' in line and 'WRITE-INS' not in line and 'BLANKS' not in line:

                                    line = line.replace(" SCHOOL COMMITTEE", "").strip()

                                    candidate_name = re.match(r'^[A-Za-z.,\s-]+', line.strip())
                                    candidate_name = candidate_name.group(0).strip()

                                    attributes.append(candidate_name)
                                    attributes.append(place)

                                    ballots_received = get_ballots_received(line)

                                    precinct_list = amend_precinct_list(len(ballots_received))

                                    append_rows(attributes, precinct_list, ballots_received)

                                    place += 1
                                    attributes.pop()
                                    attributes.pop()
                                
                                    


final_df = pd.DataFrame(data_rows)
final_df = final_df[~final_df['Precinct'].str.contains('Total', case = False, na = False)]
                                   
if os.path.exists(outfile):
    book = load_workbook(outfile)
    with pd.ExcelWriter(outfile, engine = 'openpyxl', mode = 'a', if_sheet_exists = 'replace') as writer:
        writer._book = book
        final_df.to_excel(writer, sheet_name = 'School Committee Election Data', index = False)
else:
    with pd.ExcelWriter(outfile, engine = 'openpyxl', mode = 'w') as writer:
        final_df.to_excel(writer, sheet_name = 'School Committee Election Data', index = False)



                            
                    



                                
