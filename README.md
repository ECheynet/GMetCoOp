# Exploring the MetCoOp-Ensemble Prediction System data

[![View Exploring the MetCoOp-Ensemble Prediction System data on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://se.mathworks.com/matlabcentral/fileexchange/89022-exploring-the-metcoop-ensemble-prediction-system-data)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4636108.svg)](https://doi.org/10.5281/zenodo.4636108)
[![Donation](https://camo.githubusercontent.com/a37ab2f2f19af23730565736fb8621eea275aad02f649c8f96959f78388edf45/68747470733a2f2f77617265686f7573652d63616d6f2e636d68312e707366686f737465642e6f72672f316339333962613132323739393662383762623033636630323963313438323165616239616439312f3638373437343730373333613266326636393664363732653733363836393635366336343733326536393666326636323631363436373635326634343666366536313734363532643432373537393235333233303664363532353332333036313235333233303633366636363636363536353264373936353663366336663737363737323635363536653265373337363637)](https://www.buymeacoffee.com/echeynet)

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
