# Phased Array Antennas
> The MATLAB scripts in this repo theoretically demonstrate the versatility of phased-array antennas compared to other antenna topologies (i.e. dipoles, horns, etc.).
> The radiation pattern of phased-array antennas can be electronically steered and shaped, while for other topologies the radiation pattern is practically fixed.

## Intro

Phased-array antennas are constructed *simply* by arranging a number of individual antennas (dipoles, horns, etc.) to form an array.

<p align="center">
  <img src=pics/dipole_phased_array_antenna.png width="300" height="300">
</p>
<p align="center">
  Linear Phased-Array Antenna of Dipoles
</p>

#### Radiation Pattern

###### Single Antenna Topologies

Given the voltage and current distributions present in an antenna, when energized, the corresponding E-field and H-field can be calculated and consequently the radiation pattern found from the time-average Poynting Vector:

$ S_{av} = \frac{1}{2}  \mathbb{R} [\tilde{E} \times \tilde{H^*} ] $

Using MATLAB's Antenna Designer app, we can obtain the radiation patterns of a dipole, a horn and helix antenna:

<p align="center">
  <img src=pics/dipole_radiation.png>
</p>
<p align="center">
  Voltage and current distributions, 2D and 3D radiation pattern of dipole antenna
</p>
<p align="center">
  <img src=pics/helix_horn_radiation.png>
</p>
<p align="center">
  3D and 2D radiation pattern of helix and horn antennas
</p>

## How to use

The example scripts and modules can be downloaded or cloned (if you would like to collaborate) to your local machine. Once retrieved, the `eisBasics.py` script is a good first example to become familiar with the code.

##### Eg: Purely Capacitive Coating

Given a hypothetical electrode with a coating material, the behavior appears to be purely capacitive. For a 1 $cm^2$ electrode with a 25 $\mu m$ deep coating and relative permittivity $(\varepsilon_r = 6)$ we can model the interface as a capacitor in series with the electrolyte resistance.



With this circuit model, the Bode and Nyquist plots can be obtained.

* Bode:
![PureCapBode](pics/CapacitiveElectrodeBode.png)

* Nyquist:
![PureCapNy](pics/CapacitiveElectrodeNyquist.png)

## Next Steps

Neural interface devices with embedded electrodes have a more complex behavior. Therefore, they are modeled with more complex electric circuits. The module `eismodels.py` includes several theoretical models (Randles, Warburg, etc.) and functionality to create a tailored circuit model.
