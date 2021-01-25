# Phased Array Antennas
> The MATLAB scripts in this repo theoretically demonstrate the versatility of phased-array antennas compared to other antenna topologies (i.e. dipoles, horns, etc.).
> The radiation pattern of phased-array antennas can be electronically steered and shaped, while for other antenna topologies the radiation pattern is practically fixed.

## Intro

Phased-array antennas are constructed by arranging a number of individual antennas (dipoles, horns, etc.) to form an array. In the array, attenuators and phase sifters can be used to control the magintude and phase of the signal feeding each antenna.

<p align="center">
  <img src=pics/dipole_phased_array_antenna.png width="300" height="300">
  <img src=pics/phased_array_diagram.png  width="450" height="325">
</p>
<p align="center">
  Dipoles forming a linear Phased-Array Antenna (left) and complete circuit diagram (right)
</p>

### Radiation Pattern

#### Single Antenna Topologies

Given the voltage and current distributions present in an antenna when energized, the corresponding E-field and H-field can be calculated. Consequently the radiation pattern can be found from the time-average Poynting Vector:

<img src="https://render.githubusercontent.com/render/math?math=S_{av} = \frac{1}{2}  \mathbb{R} [\tilde{E} \times \tilde{H^*} ]">

$ S_{av} = \frac{1}{2}  \mathbb{R} [\tilde{E} \times \tilde{H^*} ] $

Using a software like MATLAB's Antenna Designer app, we obtain the radiation patterns of a dipole, a horn and helix antenna:

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

As shown, for each antenna there is a corresponding radiation pattern associated with them. The dipole antenna has its characteristic omnidirectional pattern while the helix and horn have a *pointier* pattern with higher directivity at boresight. Very little can be done to shape the radiation pattern of these antennas, a constraint that is present in communication systems. Phased-array antennas can alleviate this constraint and provide versatility in the radiation pattern.

#### Phased-array antennas
###### How it works - wave interference
The physical principle behind a versatile radiation pattern is **wave interference**. The interference phenomena in waves was discovered a long time ago and is no novel concept in the field. However, as with many other fields in engineering, the recent advances in mixed-signal hardware and novel digital signal processing (DSP) algorithms has allowed for the closed-loop implementation of phased-array antennas into back end systems, such as transmitter and receiver systems. Without these improvements, the implementation of phased-array antennas was limited to complex and mostly analog systems such as the AN/FPS-85 Phased Array Radar facility in Florida.

Recall from the double slit experiment that due to constructive and destructive interferace of waves, the resulting wave intensity pattern of two wave sources resembles the amplitude of a *sinc* function.

<p align="center">
  <img src=pics/wave_interferance.png width="500" height="400">
</p>
<p align="center">
  Double-slit experiment illustrating the interference phenomena
</p>

Applying this concept and with control over the relative amplitude and phase of each source wave gives rise to phased-array antennas.

## Beam Profiles

The default radiation pattern for a linear phased-array antenna

### Steering

## Next Steps

Neural interface devices with embedded electrodes have a more complex behavior. Therefore, they are modeled with more complex electric circuits. The module `eismodels.py` includes several theoretical models (Randles, Warburg, etc.) and functionality to create a tailored circuit model.
