----------------------Code description---------------
The code of this folder is used to calculate global N and P deposition
1. N_dep.py: Transform the unit of monthly N deposition, and calculate the total N depostion by summin up noy and nhx
2. P_dep_Formate_Trans_asc2nc.py: Transform P deposition from .asc to .nc format
3. Get_Daily_NP_dep.bash: Downscale monthly and annual deposition to daily scale by taking the average
4. Opt_Temp_Trans_M2A.py: Transform monthly N depostion to annual scale (if needed)

----------------------Original dataset---------------
[N deposition] 
Unit: gN m-2 month-1
Variables: 
    1 - oxidized N deposition (noy: NOx) 
    2 - reduced N depositon (nhx: NH3)
Temporal scale: 1901-2021, monthly
Spatial scale: global, 0.5 degree
Data format: .nc
Data source: Jia Yang, Hanqin Tian (2023): ISIMIP3a N-deposition input data (v1.3). ISIMIP Repository. https://doi.org/10.48364/ISIMIP.759077.3

[P deposition] 
Unit: kg P ha-1 y-1
Variable: P depostion
Temporal scale: ~2000, 1 year data
Spatial scale: global, 0.5 degree
Data source: Mahowald, N., Jickells, T. D., Baker, A. R., Artaxo, P., Benitez-Nelson, C. R., Bergametti, G., Bond, T. C., Chen, Y., Cohen, D. D., Herut, B., Kubilay, N., Losno, R., Luo, C., Maenhaut, W., McGee, K. A., Okin, G. S., Siefert, R. L., & Tsukuda, S. (2008). Global distribution of atmospheric phosphorus sources, concentrations and deposition rates, and anthropogenic impacts. Global Biogeochemical Cycles, 22(4). https://doi.org/10.1029/2008GB003240

----------------------Transformed data------------
[N deposition] 
Unit: kg N ha-1 day-1, kg N ha-1 month-1, kg N ha-1 y-1
Variables: 
    1 - oxidized N deposition (noy: NOx) 
    2 - reduced N depositon (nhx: NH3)
    3 - N_total_depostion
Temporal scale: 1901-2021, daily, monthly, annual
Spatial scale: global, 0.5 degree
Data format: .nc

[P deposition] 
Unit: kg P ha-1 day-1, kg P ha-1 y-1
Variable: P_total_depostion
Temporal scale: 1980-2020, daily
Spatial scale: global, 0.5 degree
Data format: .nc