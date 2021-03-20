function [data] = MET3P(targetLat,targetLon,targetYear,targetMonth,...
    targetDay,targetHour,type,output,resolution)
% 
% [data] =
% MET3P(targetLat,targetLon,targetYear,targetMonth,targetDay,targetHour,type,output,resolution)
% reads the data from MEPS (MetCoOp-Ensemble Prediction System) and
% observations from met.no, Netatmo, and Bergensvaeret and resample them as
% gridded data. The data are available from a latitude of +52 deg to +74 deg
% and from a longitude from -11 deg to +42 deg- The data source is
% available on https://thredds.met.no/.
%
% Input:
%    * targetLat: [1x1] or [1xNlat] double: target latitude where the data
%         should be extracted
%    * targetLon: [1x1] or [1xNlon] double: target longitude where the data
%         should be extracted
%    * targetYear: [1x1] or [1xNyear] double: year(s) from which the data are
%         taken
%    * targetMonth: [1x1] or [1xNmonth] double: month(s) from which the data are
%         taken
%    * targetDay: [1x1] or [1xNday] double: day(s) from which the data are
%         taken
%    * targetHour: [1x1] or [1xNhour] double: hour(s) from which the data are
%         taken
%    * type: string: version of the data used. It can be 'rerun version 2',
%     'rerun version 1' or'Operational'
%    * output: cell of string: Name of the variables to read and extract
%    from the netcdf file
%    resolution: [1x1]:double: resolution, in degree for the gridded data
%
% Outputs:
%   * data: structure with the following fields
%       - time: [1x1] datetime
%       - LAF: [Nlon x Nlat] double: land_area_fraction
%       - U:  [Nlon x Nlat] double: wind_speed at 10m above the surface in
%       m/s
%       - DD:  [Nlon x Nlat] double: wind_direction at 10m above the surface
%       in deg
%       - RH:  [Nlon x Nlat] double: relative_humidity 2m  above the surface
%       - PA:  [Nlon x Nlat] double: precipitation_amount in kg/m^2
%       - I:  [Nlon x Nlat] double:
%       integral_of_surface_downwelling_shortwave_flux_in_air_wrt_time in W s/m^2
%       - P:  [Nlon x Nlat] double: air_pressure_at_sea_level in Pa
%       - T:  [Nlon x Nlat] double: air_temperature_2m in K
%       - CAF:  [Nlon x Nlat] double: cloud_area_fraction
%
%
% Author: E. Cheynet - UiB, Norway - last modified: 20-03-2021

%%
if strcmpi(type,'rerun version 2')
    typeA = 'metpparchivev2';
elseif strcmpi(type,'rerun version 1')
    typeA = 'metpparchivev1';
elseif strcmpi(type,'Operational')
    typeA = 'metpparchive';
else
    error('type unknown');
end


%% Definition of the grid
[lon,lat] = ndgrid(targetLon(1):resolution:targetLon(end),targetLat(1):resolution:targetLat(end));
%% Check month and day number + transform date into string

if targetMonth<10
    myMonth = ['0',num2str(targetMonth)];
else
    myMonth = num2str(targetMonth);
end

if targetDay<10
    myDay = ['0',num2str(targetDay)];
else
    myDay = num2str(targetDay);
end

if targetHour<10
    myHour = ['0',num2str(targetHour)];
else
    myHour = num2str(targetHour);
end
myYear = num2str(targetYear);
%% Preallocation and initalisation
data = struct('time',[],'LAF',[],'U',[],'DD',[],'RH',[],'PA',[],'I',[],...
    'P',[],'T',[],'CAF',[]);

urldat= ['https://thredds.met.no/thredds/dodsC/',typeA,'/',myYear,'/',myMonth,'/',myDay,'/met_analysis_1_0km_nordic_',myYear,myMonth,myDay,'T',myHour,'Z.nc'];
time0 = ncread(urldat,'time')./86400+datenum('1970-01-01 00:00:00');
data.time = datetime(datestr(double(time0)));

lon00 = ncread(urldat,'longitude');
lat00 = ncread(urldat,'latitude');
dummyLat = lat00(:);
dummyLon = lon00(:);
ind = find(dummyLat>=min(targetLat(:)-0.1) & dummyLat <= max(targetLat(:)+0.1) & dummyLon>=min(targetLon(:)-0.1) & dummyLon <= max(targetLon(:)+0.1));

%% Read the data in a for loop for each selected output
%  Data are resampled spatially as gridded data
Nout = numel(output);

for ii=1:Nout
    myVar0 = ncread(urldat,output{ii});
    dummyVar = double(myVar0(:));
    F_Var = scatteredInterpolant(dummyLat(ind),dummyLon(ind),dummyVar(ind),'linear','none');
    %     data.U = griddata(lon00,lat00,double(myVar0),lon,lat);
    
    if strcmpi(output{ii},'land_area_fraction')
        data.LAF = F_Var(lat,lon);
    elseif strcmpi(output{ii},'wind_speed_10m')
        data.U = F_Var(lat,lon);
    elseif strcmpi(output{ii},'wind_direction_10m')
        data.DD = F_Var(lat,lon);
    elseif strcmpi(output{ii},'relative_humidity_2m')
        data.RH = F_Var(lat,lon);
    elseif strcmpi(output{ii},'precipitation_amount')
        data.PA  = F_Var(lat,lon);
    elseif strcmpi(output{ii},'integral_of_surface_downwelling_shortwave_flux_in_air_wrt_time')
        data.I  = F_Var(lat,lon);
    elseif strcmpi(output{ii},'air_pressure_at_sea_level')
        data.P  = F_Var(lat,lon);
    elseif strcmpi(output{ii},'air_temperature_2m')
        data.T  = F_Var(lat,lon);
    elseif strcmpi(output{ii},'cloud_area_fraction')
        data.CAF  = F_Var(lat,lon);
    end
end
end

