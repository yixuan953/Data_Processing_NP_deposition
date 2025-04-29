#!/bin/bash
#-----------------------------Mail address-----------------------------

#-----------------------------Output files-----------------------------
#SBATCH --output=HPCReport/output_%j.txt
#SBATCH --error=HPCReport/error_output_%j.txt

#-----------------------------Required resources-----------------------
#SBATCH --time=600
#SBATCH --mem=250000

#--------------------Environment, Operations and Job steps-------------

# Step 1 - Transform the N, P deposition from original dataset to .nc format at half degree
# module load python/3.12.0
# python /lustre/nobackup/WUR/ESG/zhou111/Code/Data_Processing/Deposition/1_N_dep.py
# python /lustre/nobackup/WUR/ESG/zhou111/Code/Data_Processing/Deposition/1_P_dep_Format_Trans_asc2nc.py

# Step 2 - Downscale the N, P deposisiton to daily scale by taking the average
module load cdo
input_dir="/lustre/nobackup/WUR/ESG/zhou111/Data/Deposition"
process_dir="/lustre/nobackup/WUR/ESG/zhou111/Data/Processed/Deposition"
output_dir="/lustre/nobackup/WUR/ESG/zhou111/Data/Deposition"

# Transform monthly N deposition to daily scale
get_N_daily_dep(){
    cdo daysinmonth ${input_dir}/N_deposition_monthly.nc ${process_dir}/N_dep_days.nc
    cdo div ${input_dir}/N_deposition_monthly.nc ${process_dir}/N_dep_days.nc ${process_dir}/N_dep_daily_avg.nc
    cdo mon2day ${process_dir}/N_dep_daily_avg.nc ${output_dir}/N_deposition_daily_1901-2021.nc  
    echo "Monthly N deposition has been downscaled to daily"
}
get_N_daily_dep

# Transform annual P deposition in 2000 to daily scale, and expand for 40 years (assuming it maintains the same)
get_P_daily_dep(){
    cdo divc,365 ${input_dir}/P_deposition_annual_2000.nc ${process_dir}/P_dep_days.nc # Compute daily value from annual total

    # Create a daily time axis from 1980-01-01 to 2020-12-31 (inclusive): Total days from 1980 to 2020 = 365*41 + 11 leap days = 14976
    cdo -setreftime,1980-01-01,00:00:00,1day \ 
    -setcalendar,standard \
    -settaxis,1980-01-01,00:00:00,1day \
    -for,1,14976 ${process_dir}/P_dep_days.nc ${output_dir}/P_deposition_daily_1980-2020.nc

    echo "Annual P deposition of year 2000 has been downscaled to daily (1980–2020)"
}
get_P_daily_dep