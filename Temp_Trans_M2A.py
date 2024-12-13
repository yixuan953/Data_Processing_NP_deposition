# This code is used to transform monthly N deposition (1901 - 2021)

import xarray as xr
from netCDF4 import num2date
import os
import pandas as pd
import numpy as np

# Load the .nc file
raw_data_path = "C:/Users/zhou111/OneDrive - Wageningen University & Research/2_Data/NP_Input/Deposition/N_deposition_monthly"
input_file = "N_depostion_monthly.nc"
output_file = "N_depostion_annual_1901-2021.nc"

month_N_dep = os.path.join(raw_data_path, input_file)
annual_N_dep = os.path.join(raw_data_path, output_file)

# Open the dataset
dataset = xr.open_dataset(month_N_dep,decode_times=False)
lat = dataset["lat"]
lon = dataset["lon"]
time = dataset["time"]

# Create a new time variable representing the years (1901 to 2021)
time_decoded = num2date(time[:], units=time.units, calendar='360_day')
# Convert the cftime.Datetime360Day to pandas datetime
time = pd.to_datetime([f'{t.year}-{t.month:02d}-{t.day:02d}' for t in time_decoded])
dataset.coords['time'] = time

years = time.year
N_time = np.arange(min(years), max(years)+1)

# Sum up the monthly N depostion to annual
annual_data = dataset.resample(time='YE').sum()
# Create a new dataset with the summed annual data
annual_dataset = xr.Dataset(
    {
       "noy": (["time", "lat", "lon"], annual_data["noy"].values),
       "nhx": (["time", "lat", "lon"], annual_data["nhx"].values),
       "N_total_dep": (["time", "lat", "lon"], annual_data["N_total_dep"].values)
    },
       coords={
        "lat": lat,
        "lon": lon,
        "time": N_time
         }
)

annual_dataset["nhx"].attrs["units"] = "Kg N ha-1 y-1"
annual_dataset["noy"].attrs["units"] = "Kg N ha-1 y-1"
annual_dataset["N_total_dep"].attrs["units"] = "Kg N ha-1 y-1"

annual_dataset.to_netcdf(annual_N_dep)

dataset.close()
annual_dataset.close()