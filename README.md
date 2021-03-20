# Exploring the MetCoOp-Ensemble Prediction System data

[![View Exploring the MetCoOp-Ensemble Prediction System data on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://se.mathworks.com/matlabcentral/fileexchange/89022-exploring-the-metcoop-ensemble-prediction-system-data)

## Summary

The data from MEPS (MetCoOp-Ensemble Prediction System) [1] are extracted from the THREDDS Data Server of the Norwegian Meteorological Institute [2]. The data source is made of netcdf files. The OPeNDAP framework is used to read the data without downloading them. The data are resampled as gridded data.

## Content

The repository contains:

An example file Documentation.mlx as a Matlab live script
The function MET3P.m, which read and extract the data remotely and resample them as gridded data

This is the first version of the submission. Several bugs may be present. Future versions will improve the example file.

## References

[1] https://www.met.no/en/projects/metcoop
[2] https://thredds.met.no


## Example 1 (Storam Aina in Scandinavia) 

The fitting of the extended SEIR model to real data provides the following results:

![stormAina](stormAina_onlySea.jpg)


## Example 2 (Temperature Map) 

The fitting of the extended SEIR model to real data provides the following results:

![Temperature map during storm Aina](Temperature_map.jpg)


## Example 3 (Animation of storm Aina. from 1 am to 3 pm on 08-12-2017) 

![nice gif](sotrm_Norway_animated.gif)
