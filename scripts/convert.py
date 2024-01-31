import csv

#script for bisulfite converting

#takes in a string of input from a FASTA file and returns a string of just the base pair sequence
def edit(strinput, taxID):
    #get rid of empty lines (ex. before the first >)
    if len(strinput) == 0:
        return ''
    
    #split the string by newlines in case there are empty lines
    codonlines = strinput.split('\n')
    
    #handle the fasta header (line that begins with >)
    #and create a string to store the sequence
    seq = ">" + codonlines[0] + "\n"
    codonlines[0] = "" #get rid of the first line
 
    #add lines to codonseq to make one long string containing the entire sequence
    for i in codonlines:
        if len(i) != 0: #skip any empty lines
            temp = i.upper()
	    seq += temp.replace("C", "T")
    return seq + "\n"

#main

from sys import argv

#input fasta file
input = open(argv[1], "r")
strinput = str(input.read())

#taxonomy ID for revised header
taxID = str(argv[2])

#split by sequences starting with >
blocks = strinput.split('>')
revisedfa = ''

for i in blocks:
    revisedfa += edit(i, taxID)

output_path = "/u/project/zaitlenlab/galenheu/kraken/reformatted/"  # Replace this with your desired directory
output_filename = f"{taxID}.fa"
output = open(output_path + output_filename, "w")
output.write(revisedfa)
output.close()
