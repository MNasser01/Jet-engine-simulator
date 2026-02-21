# Jet-engine-simulator
this is a comprehensive, MATLAB-based simulation environment designed to analyze and visualize the aero-thermodynamic performance of a turbojet engine. Developed after two months of intensive study in aircraft propulsion, this project bridges the gap between theoretical Brayton Cycle equations and real-time engineering visualization.
# AeroFlow-Sim: Integrated Turbojet Performance & Visualization Suite


---

##  Key Features

* **Analytical Depth:** Computes full engine cycle performance (Stations 0-9), calculating critical parameters such as Net Thrust (T) and Thrust Specific Fuel Consumption (TSFC).
* **Multi-Dimensional Mapping:** Generates high-fidelity 3D performance maps to investigate engine behavior across varying Mach numbers and environmental conditions.
* **Dynamic Animation:** A live-action engine schematic built using MATLAB’s **Handle Graphics**, featuring synchronized rotor rotation, thermal pulsation effects, and station-specific temperature tags.
* **Real-time Monitoring:** Includes a visual gauge for Turbine Inlet Temperature (T4) to monitor thermal limits during the simulation.



---

##  Technical Deep Dive

    File Structure
* `Main_Analysis.m`: The primary script that solves the cycle equations and generates performance matrices.
* `DrawEngineAnimated.m`: The core visualization function. It uses efficient object-oriented graphics updating (`set YData`) instead of re-plotting, ensuring a high frame rate.
* `drawSmartTag.m`: A specialized sub-function for rendering dynamic data arrows at engine stations.

   Mathematical Methodology
The engine is modeled through 5 major thermodynamic stations:
1.  **Station 0-2 (Inlet):** Ambient capture and ram recovery.
2.  **Station 2-3 (Compressor):** Isentropic compression based on Pressure Ratio ($r_c$).
3.  **Station 3-4 (Combustor):** Heat addition to reach specified $T_{max}$.
4.  **Station 4-5 (Turbine):** Work extraction to drive the compressor.
5.  **Station 5-9 (Nozzle):** Gas expansion to exhaust velocity ($V_9$) for thrust generation.



---

 Engineering Assumptions

To provide a robust baseline, the following idealizations were applied:
* **Ideal Brayton Cycle:** 100% Isentropic efficiency for all turbomachinery.
* **Gas Model:** Calorically perfect gas ($\gamma=1.4$) with constant specific heats.
* **Ideally Expanded Nozzle:** Exhaust pressure matches ambient ($P_9 = P_a$).
* **Zero Pressure Losses:** No pressure drop during the combustion process.
* **Mass Conservation:** Fuel mass flow is neglected relative to air mass flow 
* **Installation:** Ideal nacelle integration (Additive drag is offset by forebody suction).

---

  How to Run
1.  Clone the repository to your local machine.
2.  Open MATLAB and navigate to the project folder.
3.  Run the main script (e.g., `Main_Analysis.m`).
4.  The 3D performance plots will generate, followed by the live-action engine visualizer.

---

  Future Roadmap
*  Integration of Non-Ideal effects (Polytropic efficiencies).
*  Off-design analysis using Compressor/Turbine Maps.
*  Transitioning to MATLAB App Designer for an interactive UI.


**Developed by Mahmoud Nasser** *Mechanical power Engineering Student, Propulsion Systems Engineering Enthusiast | MATLAB Developer*
