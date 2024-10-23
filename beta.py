#!/usr/bin/env python
################################################################
#beta.py takes a directory of Bracken output files
#and calculates a matrix of Bray-Curtis dissimilarity metrics, outputting to CSV.
################################################################
import os, sys, argparse
import numpy as np
import csv

####################################################################
#Main method
def main():
    # Parse arguments
    parser = argparse.ArgumentParser(description='Calculate Bray-Curtis dissimilarities between Bracken files.')
    
    # Accept only a directory of Bracken files
    parser.add_argument('-d', '--directory', required=True, dest='input_dir',
                        help='Input directory containing Bracken files for comparison')
    
    # Output CSV file
    parser.add_argument('-o', '--output', required=True, dest='output_file',
                        help='Output CSV file to save the dissimilarity matrix')
    
    args = parser.parse_args()

    # Check if input is a directory
    if not os.path.isdir(args.input_dir):
        sys.stderr.write(f"Error: {args.input_dir} is not a valid directory\n")
        exit(1)

    # Get all .bracken files in the directory
    bracken_files = [os.path.join(args.input_dir, f) for f in os.listdir(args.input_dir) if f.endswith('.bracken')]
    
    if len(bracken_files) < 2:
        sys.stderr.write(f"Error: {args.input_dir} must contain at least two .bracken files\n")
        exit(1)

    #################################################
    # Read in Bracken files
    i2totals = {}
    i2counts = {}
    num_samples = 0
    taxlvl_col = 2
    count_col = 5
    categ_col = 0

    bracken_files.sort(key=lambda x: int(os.path.basename(x).split('.')[0]))  # Sort by sample number

    for f in bracken_files:
        i_file = open(f, 'r')
        i2totals[num_samples] = 0
        i2counts[num_samples] = {}

        for line in i_file:
            l_vals = line.strip().split("\t")

            # Skip empty lines, headers, or comments
            if len(l_vals) == 0 or (not l_vals[count_col].isdigit()) or l_vals[0] == '#':
                continue

            if int(l_vals[count_col]) > 0:
                tax_id = l_vals[categ_col]
                i2totals[num_samples] += int(l_vals[count_col])
                if tax_id not in i2counts[num_samples]:
                    i2counts[num_samples][tax_id] = 0
                i2counts[num_samples][tax_id] += int(l_vals[count_col])

        i_file.close()
        num_samples += 1

    #################################################
    # Calculate Bray-Curtis Dissimilarities
    bc = np.zeros((num_samples, num_samples))
    for i in range(num_samples):
        i_tot = i2totals[i]
        for j in range(i + 1, num_samples):
            j_tot = i2totals[j]
            C_ij = 0.0
            for cat in i2counts[i]:
                if cat in i2counts[j]:
                    C_ij += min(i2counts[i][cat], i2counts[j][cat])
            # Calculate Bray-Curtis dissimilarity
            bc_ij = 1.0 - ((2.0 * C_ij) / float(i_tot + j_tot))
            bc[i][j] = bc_ij
            bc[j][i] = bc_ij

    #################################################
    # Output the Bray-Curtis dissimilarity matrix to a CSV file
    with open(args.output_file, mode='w', newline='') as csv_file:
        writer = csv.writer(csv_file)
        
        # Write header (sample numbers)
        header = [''] + [str(i + 1) for i in range(num_samples)]
        writer.writerow(header)
        
        # Write the dissimilarity matrix
        for i in range(num_samples):
            row = [str(i + 1)] + [f"{bc[i][j]:.3f}" for j in range(num_samples)]
            writer.writerow(row)

    print(f"Bray-Curtis dissimilarity matrix saved to {args.output_file}")

####################################################################
if __name__ == "__main__":
    main()
