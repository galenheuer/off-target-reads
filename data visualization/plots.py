import sys
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

def plot_and_save(csv_file):
    # Read data from CSV file
    df = pd.read_csv(csv_file, index_col=0)

    # Bar Plot for Overall Abundance
    plt.figure(figsize=(12, 6))
    sns.barplot(data=df.T)
    plt.title('Overall Abundance of Bacterial Genera')
    plt.xlabel('Bacterial Genera')
    plt.ylabel('Abundance')
    plt.savefig('overall_abundance_plot.png')
    plt.show()

    # Box Plot for Individual Genera
    plt.figure(figsize=(12, 6))
    sns.boxplot(data=df.melt(id_vars=None, var_name='Sample', value_name='Abundance'), x='Genus', y='Abundance')
    plt.title('Distribution of Microbial Abundance for Each Genus')
    plt.xlabel('Bacterial Genera')
    plt.ylabel('Abundance')
    plt.savefig('box_plot_individual_genera.png')
    plt.show()

    # Heatmap for Correlation
    correlation_matrix = df.corr()
    plt.figure(figsize=(12, 8))
    sns.heatmap(correlation_matrix, annot=True, cmap='coolwarm')
    plt.title('Correlation Heatmap')
    plt.savefig('correlation_heatmap.png')
    plt.show()

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script_name.py <csv_file>")
        sys.exit(1)

    csv_file_path = sys.argv[1]
    plot_and_save(csv_file_path)

