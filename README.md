Please cite: Xu, L., Chang, KC., Payne, E.M. et al. Mapping enzyme catalysis with metabolic biosensing. Nat Commun 12, 6803 (2021). https://doi.org/10.1038/s41467-021-27185-9

# Mass_spec_image_UMAP
## Contents
Overview
1.	System Requirements
2.	Installation Guide
3.	Demo
4.	Instructions for use
## Overview
The package here is used to generate the UMAP clustering based on the data of mass spectrum imaging (MSI) by using R and MATLAB.
## 1.	System Requirements
- Hardware Requirements:
The scripts we used for the paper requires only a standard computer with enough RAM to support the operations defined by a user. For minimal performance, this will be a computer with about 8 GB of RAM. For optimal performance, we recommend a computer with the following specs:
RAM: 64+ GB
CPU: 4+ cores, 3.3+ GHz/core
The runtimes below are generated using a computer with the recommended specs (8 GB RAM, 4 cores@3.3 GHz) and internet of speed 25 Mbps.
- OS Requirements:
All scripts are tested on Linux operating systems with the following specifics:
Linux: Ubuntu 18.04
- Software Requirements:
Before running the R and MATLAB scrip below, users should have R version 4.1.0 or higher, and several packages set up from CRAN. For MATLAB, the version should be 2019 or higher.

## 2.	Installation Guide
- Installing R version 4.1 on Ubuntu 18.04
The latest version of R can be installed by adding the latest repository to apt:
```
sudo echo "deb http://cran.rstudio.com/bin/linux/ubuntu xenial/" | sudo tee -a /etc/apt/sources.list
gpg --keyserver keyserver.ubuntu.com --recv-key E084DAB9
gpg -a --export E084DAB9 | sudo apt-key add -
sudo apt-get update
sudo apt-get install r-base r-base-dev
```
which should install in about 20 seconds.

- Installing Cardinal, data.table and Seurat packages in R

Seurat is developed by [Satija lab](https://satijalab.org/seurat/index.html) and it is available on CRAN for all platforms. To install, run:
```
install.packages('Seurat')
library(Seurat)
```
which takes around 2 minutes.


Cardinal is developed by [Vitek lab](https://cardinalmsi.org/) and it is available from Bioconductor. To install, run:
```
if (!requireNamespace("BiocManager", quietly=TRUE))
    install.packages("BiocManager")
BiocManager::install("Cardinal")
```
which takes around 1 minute.


Data.table is the standard package in R and to install, run:
```
install.packages("data.table")
library(data.table)
```
which takes around 1 minute.

- Installing Matlab version 2019 on Ubuntu 18.04
The latest version of Matlab for Linux installer can be downed from https://www.mathworks.com/products/matlab.html. Then unzip the file to install it, which should install in about 30 minutes.

## 3.	Demo
The demonstration data (demo.imzML, demo.ibd, demo_mz_127_slice.csv) are randomly selected from an area covering one subarray of 10 by 10 microwells (Figure 2A, Blue Box) based on the imzML data file of the whole slide that used in Figure 2 of the main text. Following the steps below with the demo files, users can generate a UMAP clustering. The expected run time for demo takes around 30 minutes.
- ### Step_0)	This step is to install the customized matlab app, which takes around 1 minutes:
Start MATLAB and then open the Step_0.mlappinstall to install the customized matlab app. Under the ‘APPS’ tab at the top left in MATLAB, ‘Step0_FindParameters’ button should appear beneath the ‘MY APPS’ group.
- ### Step_1)	This step is to align the position of microwells on the slide to the MSI using the MATLAB app installed previously. This step is done by getting the position information of each microwells corresponding to one slice of the MSI data at m/z 127, where the target molecular is. Also in this step we check the background noise level and how many pixels from the MSI belongs to one microwell, this step takes around 1 minutes: 
Open the ‘Step0_FindParameters’ app in MATLAB. Click ‘File’ on the top left of the app window and choose ‘demo_mz_127_slice.csv’. Two plots will show up. Based on the plot of the data, corresponding parameters can be setted. For the demo file, only change ‘Y threshold’ to ‘50’ and the press Enter. Then click ‘File’ again, choose ‘Export circled data’ and name the exported file ‘test’ in csv format. Then close all the windows.

- ### Step_2)	This step is to align the MSI data based on the mass spectrum peaks in R using Cardinal package, which takes around 1 minute:
Make sure the demo folder is set as the working directory and then run the Step_2.r script in R. Two files, ‘demo.csv’ and ‘demo.dat’, are generated in the same folder.

- ### Step_3)	This step is to get the mass spectrum data from each microwells based on the position information in step 1. Then normalize the mass spectrum data from the microwells containing library members with the data from the microwells that containing positive controls. Also, a list of mass spectrum peaks that are most different between the library members and the positive control are generated, this step takes around 5 minutes:
Open the Step_3.m script in MATLAB, and then click ‘Run’. Two files, ‘ExtractedDGE_demo.csv’ and ‘mz_list.txt’, are generated in the same folder.

- ### Step_4)	This step is to draw UMAP clustering based on the normalized data in Step 3 based on the list of differential mass spectrum peaks in R using Seurat package, which takes around 1 minute:
Make sure the demo folder is set as the working directory and then run the Step_4.r script in R to get the UMAP clustering plot as shown below:
![This is an image](https://github.com/AbateLab/Mass_spec_image_UMAP/blob/main/UMAP.jpg)

Then use the feature plot function in the Seurat package to draw the heatmap of interested m/z. Below are the sample plot for m/z 127 and m/z169:
![This is an image](https://github.com/AbateLab/Mass_spec_image_UMAP/blob/main/featureplot.jpg)

## 4.	Instructions for use
Similar to the demo, any mass spec ion imaging data in imzML format can be processed following the steps in the Demo sections. Depending on the size of the data, the run time may take various times. In our case, the imzML file for the 75mm by 25 mm slide is around 90 Gb and takes a computer with 128 Gb memory 12 hours to generate the plot in Figure 2 B, C and D. The UMAP clustering may not look exactly the same while the number of groups and the distance among them should be similar.


