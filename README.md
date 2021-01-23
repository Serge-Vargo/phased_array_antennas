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

Given the voltage and current distributions present in an antenna, when energized, we can calculate the corresponding E-field and H-field and consequently find the radiation pattern from the time-average Poynting Vector:

![\Large x=\frac{-b\pm\sqrt{b^2-4ac}}{2a}]

Electrochemical Impedance Spectroscopy (EIS) is a laboratory technique that provides impedance characterization for electrode-electrolyte interfaces. This technique allows us to model such an interface as an electric circuit consisting of lump elements. Impedance characterization is very important in the field of neural engineering as it provides valuable information of the electrical performance of a neural interface device.

For example, an electrode placed in the surface of the brain will come in contact with the cerebrospinal fluid and brain tissue. The goal is to couple the electrode to neurons to record brain activity and avoid interaction with other brain cells that might interfere in the recording. Changes in the impedance are often correlated to cell spreading and locomotion, bacterial growth and antigen-antibody reactions caused by the intrusion of a foreign object in the brain.

In this project, the module `eismodels.py` provides equivalent circuit models that have long been used to model interface impedance: Warburg elements, Randles cell, Gouy-Chapman-Stern model, and others. A combination of these models can also be obtain to characterize the performance of a neural probe under test.

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
