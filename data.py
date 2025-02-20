import itertools
import os
import plotly.express as px
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd
import math
import numpy as np
import re

from scipy import stats

from pathlib import Path

data_order = {}

sas_data_folder = str(Path.home()) + "\\Documents\\School\\GVSU\\Research\\SAS\\SAS_Data\\"

csv_file_name = "all_iterations.csv"
# csv_file_name = "10_iterations.csv"

COLUMNS = {"Machine": str, "Run": int, "Time": float, "Framerate": float, "FPS_Satisfaction": float, 
           "Camera_Zoom": float, "Smoothing": bool, 
           "Number_Of_Enemies_Per_Second": float, "Number_Of_Enemies_Min": float, "Number_Of_Enemies_Max": float, 
           "Enemy_Size_Range_Min": float, "Enemy_Size_Range_Max": float, 
           "Enemy_Size_Min": float, "Enemy_Size_Max": float, 
           "Enemy_Velocity_Range_Min": float, "Enemy_Velocity_Range_Max": float,
           "Enemy_Velocity_Min": float, "Enemy_Velocity_Max": float, 
           "Enemy_Sight": float, "Enemy_Sight_Min": float, "Enemy_Sight_Max": float,
           "Score": float, "Player_Size": float, "Number_Of_Enemies": int, 
           "Zoom_Adaptations": int, "Enemy_Adaptations": int}

# indexes = COLUMNS[0:2]

def iterate_subfolders(root_dir):
    """
    Iterates over direct subfolders within the given root directory and returns a dictionary.
    
    Args:
        root_dir (str): The path to the root directory.
    
    Returns:
        dict: A dictionary where keys are folder names and values are their corresponding paths.
    """
    subfolders = {}

    # Get only the first level of subdirectories
    try:
        _, dirnames, _ = next(os.walk(root_dir))  # Get only the immediate children
        for dirname in dirnames:
            subfolder_path = os.path.join(root_dir, dirname)
            subfolders[dirname] = subfolder_path + "\\"
    except StopIteration:
        pass  # Handle the case where the directory doesn't exist or is empty

    return subfolders

def writeDataFromFile(data, folderName, file, i):
        
        while True:
                data_to_add = [folderName, i]
                data_line = file.readline()

                if(data_line == ""):
                        break;
                
                data_line = data_line.strip().split(",")

                for v in data_line:
                        match = re.match(r"\(([^)]+)\)", v)  # Match (x y) format
                        if match:
                                x, y = match.group(1).split()  # Split by space
                                data_to_add.extend([x, y])  # Store as separate columns
                        else:
                                data_to_add.append(v)  # Store normal values as is

                if len(data_to_add) != len(COLUMNS):
                        print(f"Skipping malformed row in {file.name}: {data_to_add}")
                        continue  # Skip this row

                data.append(data_to_add)

def setTypes(df):
        for colName, colType in COLUMNS.items():
                print(f"Setting {colName} to {colType}")
                df[colName] = df[colName].astype(colType)

        return df

def initDF():
        data = []
        readFromFile = False
        if os.path.isfile(sas_data_folder + csv_file_name):
                #Read in the file. 
                readFromFile = True
                data = pd.read_csv(sas_data_folder + csv_file_name)
        else:
                
                subfolders = iterate_subfolders(sas_data_folder)
                for folderName, folderPath in subfolders.items():
                        print(f"Reading files from {folderName}")
                        for i in range(0, 100):
                                file_path = folderPath + "Run " + str(i) + ".txt"
                                
                                if not os.path.exists(file_path):
                                        continue
                                
                                f = open(file_path, 'r')

                                writeDataFromFile(data, folderName, f, i)

        df = pd.DataFrame(np.array(data), columns = COLUMNS.keys())

        df = setTypes(df)      

        if not readFromFile:
               df.to_csv(sas_data_folder + csv_file_name, index=False)

        return df

# Set a MultiIndex with (run, frame)
# df.set_index(indexes, inplace=True)
df = initDF()


pd.set_option('display.max_rows', None)

# Display all columns
pd.set_option('display.max_columns', None)

machines = df['Machine'].unique()

allCombinations = list(itertools.combinations(machines, 2))

for _, v in enumerate(allCombinations):
        dataset1 = df[df['Machine'] == v[0]]
        dataset2 = df[df['Machine'] == v[1]]
        
        enemyAdaptations1 = dataset1.groupby("Run")["Enemy_Adaptations"].max()
        enemyAdaptations2 = dataset2.groupby("Run")["Enemy_Adaptations"].max()

        print(f"p value for {v[0]} and {v[1]}: {stats.mannwhitneyu(enemyAdaptations1, enemyAdaptations2).pvalue}")


# print(df.dtypes)
# print(df.corr())

run_0 = df[df['Run'] == 0]
run_9 = df[df['Run'] == 9]

fig = px.line(run_9, x='Time', y='FPS_Satisfaction', color="Machine")
# fig.show()

groupbyruns_noindex = df.groupby("Run")
groupbyruns = df.groupby("Run", as_index = False)

# number_of_zoom_adaptations = groupbyruns["Zoom_Adaptations"].max()
#I could try the shift magic stuff to get this calculation?
# print(df.head())

# Create the bar chart for the mean values
plt.figure(figsize=(8, 6))

# Create a boxplot
sns.boxplot(y=df['Zoom_Adaptations'], color='#1f77b4')

# Set labels and title
plt.ylabel('Zoom Adaptations')
plt.xlabel('')
plt.title('')

plt.tight_layout()

# Show the plot
# plt.show()


# number_of_enemy_adaptations = groupbyruns["Enemy_Adaptations"].max()
plt.figure(figsize=(8, 6))

# Create a boxplot
sns.boxplot(y=df['Enemy_Adaptations'], color='#1f77b4')

# Set labels and title
plt.ylabel('Enemy Adaptations')
plt.xlabel('')
plt.title('')

plt.tight_layout()

# Show the plot
# plt.show()

#Number of violations - Number of times FPS satisfaction drops to 0?
#                     - Zooom
fredericksruns = df[df['Machine'] == 'Latitude']

frederick_groupbyruns = fredericksruns.groupby("Run")

violations = frederick_groupbyruns.apply(
    lambda g: (
        ((g["FPS_Satisfaction"] == 0) & (g["FPS_Satisfaction"].shift(1) != 0)).sum() +
        ((g["Framerate"] == 0) & (g["Framerate"].shift(1) != 0)).sum()
    ),
    include_groups=False  # Fixes the DeprecationWarning
).reset_index(name='Violations')

# print(violations.head())


# fig = px.bar(violations, x='Run', y='Violations')
# fig.show()

# print(violations)

