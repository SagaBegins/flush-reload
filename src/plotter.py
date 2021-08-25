import matplotlib.pyplot as plt
import csv
import os 
from collections import namedtuple 

# Added axis range here if needed
MachineData = namedtuple('MachineData',['label', 'user']) 

path_format = 'data/{}/{}/'
save_path_format = '../results/graph{}-{}.png'

def plotAndSave(machine_data, type):
    """
        TODO: Add doc string
    """
    formatted_path = path_format.format(machine_data.label, type)
    if type == 'testf':
        type = 'test'

    formatted_save = save_path_format.format(machine_data.label, type)

    files = os.listdir(formatted_path)

    for file in files:
        x = []
        y = []
        with open(formatted_path+file, 'r') as csvfile:
            reader = csv.reader(csvfile, delimiter=',', quotechar='|')
            for row in reader:
                x.append(int((row[0])))
                y.append(int((row[1])))        

        plt.scatter(x,y)

    # Uncomment and use desired axis range
    # if(machine_data[0] == 'A'):
    #     plt.axis([0, 500, 0, 3000])
    # elif(machine_data[0] == 'B'):
    #     plt.axis([0, 500, 0, 1000])
    # elif(machine_data[0] == 'C'):
    #     plt.axis([0, 500, 0, 1000])
    # else:
    #     plt.axis([0, 500, 0, 600])
        
    plt.legend(files)  
    plt.title(machine_data.user)
    plt.savefig(formatted_save)


def main():
    machine_data = (MachineData('A', 'mohamedanis'), MachineData('B', 'vidyasagar'), MachineData('C', 'OpenNebula AMD'), MachineData('D', 'OpenNebula Intel'))

    for machine in machine_data:
        for type in ('testf', 'notest'):
            plotAndSave(machine, type)
            plt.clf()

if __name__ == "__main__":
    main()
