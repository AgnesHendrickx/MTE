## This file is written and formatted in notepad++ in the normal text language. 
## Please use this program to view this file.

## Author - Agnes Hendrickx (a.e.hendrickx@uu.nl), Cedric Thieulot, Lennart de Groot
## Project - Revealing Global Implications of Terrain-Induced Bias in Magnetic Data: In-Depth Analysis from 3D Forward Modeling of Topography at Mt. Etna
## Faculty - Utrecht University, Faculty of Geosciences
## Department - Earth Sciences, paleomagnetic laboratory Fort Hoofddijk
## Date - 24 March 2026

------------------------------------------------------------------------------------------------------------ 
General
=======
These files are the data files of the FLUX sites, original GPS data was converted to WGS84 UTM 33N (to align with the DEMs used in the accompanying study), original data of all FLUX1, FLUX2, FLUX3, FLUX4 and FLUX5 sites is given in a Yoda repository: https://doi.org/10.24416/UU01-NQXN82 (Meyer & de Groot, 2024). The dataset contains measurements made with a fluxgate magnetometer, or AnomalyMapper, of the ambient geomagnetic field on Mt. Etna, Italy. Measurements were made in April 2018. 

File Structure
================
The data is structured as followed:
measurement point number, xcoordinate, ycoordinate, height, inclination, declination, intensity, distance (along the path)

(comma's not present in the .txt files, but noted here for clarity, deliminator in .txt file is several spaces): 

The files are named as follows:
{sitenumber}-{pathnumber}-{height run}
For FLUX1, FLUX2, FLUX3, FLUX4 height 1 corresponds to measurements at 1 meter above the surface, and height 2 corresponds to measurements at 1.8 m 
For FLUX5 height 1 corresponds to 0.25 m, height 2 corresponds to 0.75 m, height 3 corresponds to 1.25 m, and height 4 corresponds to 1.75 m
For FLUX6 height 1 corrsponds to 1 m.


A few notes
================
* During the fieldwork, the paths were chosen in such a fashion that they predominantly walked perpendicular to the slope and over certain topographical features.
* For FLUX1-5 the second path was walked "backwards" in direction compared to the first and third path, so for instance if path 1 for a site ran from south to north, then the second path runs from north to south, and the third path would again go from south to north.
* Our analysis suggested that GPS measurements at FLUX 4, path 1 and path 2 failed. The field notes (from Meyer & de Groot, 2024) suggested the GPS only broke for the second height measurements (180 cm), but we were unable to match any of the recorded measurements with comparable values of a DEM, suggesting that the GPS might have already started malfunctioning at the lower height measurements. 
* It was not always possible to see the reference location in the field, therefore the declination is not continuous as can be seen by very anomalous values in the FLUX data files. This did not affect the inclination, as this is only dependent on the leveling of the magnetometer which is done using the tilt sensor, or the intensity data, that is the length of the total vector measured irrespective of its orientation. 


Measurements were made with a fluxgate magnetometer. See for a full description of this device and data acquisition: 
De Groot, Bertwin M., and Lennart V. De Groot. "A low-cost device for measuring local magnetic anomalies in volcanic terrain."

For more information, see original paper: Meyer, R., & de Groot, L. V. (2024). Local magnetic anomalies explain bias in paleomagnetic data: Consequences for sampling. Geochemistry, Geophysics, Geosystems, 25, e2023GC011319. https://doi.org/10.1029/2023GC011319