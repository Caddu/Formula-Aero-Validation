# Formula Aero Validation

Aerodynamic development and experimental validation workflow for a Formula SAE electric vehicle.

This repository contains the computational, experimental, and data acquisition workflows developed for aerodynamic analysis and CFD–experimental correlation using a 1:8 scale wind tunnel validation methodology.

---

# Project Overview

The project combined:

- CAD and parametric automation
- CFD aerodynamic analysis
- Wind tunnel experimental testing
- Multi-channel aerodynamic force acquisition
- MATLAB signal post-processing
- Numerical–experimental correlation

CFD simulations and 1:8 scale wind tunnel testing were used to compare baseline and aerodynamic vehicle configurations.

---

# Repository Structure

## `cad-automation/`

Parametric aerodynamic geometry generation using Python and CATIA V5 automation workflows.

### Features

- Front wing automatic generation
- Rear wing automatic generation
- Parametric geometry control
- CATIA V5 VBA/VBS integration
- Rapid aerodynamic design iteration

### Files

- `front_wing_generator.py`
- `rear_wing_generator.py`
- `front_wing_macro.vbs`
- `rear_wing_macro.vbs`

---

## `post-processing/`

MATLAB scripts developed for CFD convergence analysis and aerodynamic signal post-processing.

### Features

- Aerodynamic force signal processing
- Noise filtering and smoothing
- Residual convergence evaluation
- Coefficient convergence analysis
- Experimental data correlation

### Files

- `aero_signal_post_processing.m`
- `aero_signal_post_processing_mesh.m`

---

## `wind-tunnel-daq/`

Custom multi-channel aerodynamic data acquisition system developed for experimental wind tunnel testing.

### Features

- 5-load-cell force balance architecture
- HX711-based acquisition modules
- Arduino-based DAQ system
- Real-time aerodynamic force acquisition
- Experimental force balance integration

### Files

- `arduino_firmware.c`
- `wind_tunnel_logger.py`

---

## `docs/`

Supplementary numerical validation and CFD convergence documentation.

### Contents

- Residual convergence plots
- Aerodynamic coefficient convergence plots
- Numerical solution stability verification

---

# Experimental Validation

The aerodynamic package was experimentally validated using:

- 1:8 scale wind tunnel testing
- Open-circuit wind tunnel configuration
- Custom 5-load-cell aerodynamic force balance
- Multi-channel DAQ architecture
- MATLAB-based signal post-processing
- CFD–experimental aerodynamic correlation

Experimental measurements were obtained at 60 km/h for both aerodynamic and baseline vehicle configurations.

---

# CFD Workflow

The CFD workflow included:

- External aerodynamic domain generation
- Poly-Hexcore surface and volume meshing
- Localized aerodynamic refinement strategy
- GEKO turbulence modeling
- Moving ground implementation
- Rotating wheel MRF setup
- Residual and coefficient convergence analysis

---

# Technical Documentation

Additional technical details, CFD methodology, aerodynamic instrumentation architecture, experimental setup, and validation procedures are available in the undergraduate thesis related to this project:

[View Thesis](https://bdm.unb.br/handle/10483/43883)

---

# Technologies

- Python
- MATLAB
- CATIA V5
- VBA/VBS Automation
- Arduino
- HX711
- CFD
- Wind Tunnel Experimental Testing

---

# Author

Carlos do Amaral  
Aerospace Engineering — University of Brasília (UnB)

GitHub:
github.com/Caddu/Formula-Aero-Validation
