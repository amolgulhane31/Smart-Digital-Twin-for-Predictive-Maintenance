# Smart Digital Twin for Predictive Maintenance of an Electro-Mechanical System

## 📌 Project Overview

This repository contains a **MATLAB-based Smart Digital Twin simulation** for **predictive maintenance of an electro-mechanical system**. The project demonstrates how electrical and mechanical parameters can be analyzed together to determine system health and maintenance requirements.

⚠️ **Note:** This repository currently contains **one MATLAB (.m) file**, which represents the complete simulation and logic of the digital twin.

---

## 🎯 Objectives

* Simulate a Digital Twin of an electro-mechanical system
* Monitor electrical input voltage and mechanical friction
* Detect electrical and mechanical faults
* Predict maintenance requirements using logic-based AI simulation
* Visualize system parameters and fault prediction using plots

---

## 🧠 Key Concepts Used

* Digital Twin Technology
* Predictive Maintenance
* Condition Monitoring
* Logic-Based Artificial Intelligence
* Electrical Fault Detection
* Mechanical Fault Detection

---

## 🛠️ Tools & Technologies

* **Software:** MATLAB
* **Programming Language:** MATLAB (.m)
* **Simulation Type:** Software-only (No physical hardware)
* **Conceptual Hardware Reference:** Electro-mechanical system (Motor-based)

---

## 📂 Repository Contents

```
Smart-Digital-Twin-for-Predictive-Maintenance/
│── twin.m
│── README.md
```

---

## ⚙️ System Workflow

1. User enters the input voltage.
2. Current and torque are calculated using system parameters.
3. Mechanical friction is randomly simulated.
4. Electrical fault is detected based on voltage limits.
5. Mechanical fault is detected based on friction threshold.
6. Final system health decision is made.
7. Results are displayed using graphical plots.

---

## 🔢 Fault Detection Logic

### Electrical Fault Condition

* **Healthy:** 0.95 V ≤ Input Voltage ≤ 1.05 V
* **Faulty:** Input Voltage < 0.95 V or > 1.05 V

### Mechanical Fault Condition

* **Healthy:** Friction ≤ 0.3
* **Faulty:** Friction > 0.3

### Final Decision

* If **any fault** is detected → Maintenance Required
* If **no fault** is detected → System Healthy

---

## 📊 Output & Visualization

The simulation generates:

* **Torque Bar Graph**
* **Friction Level Bar Graph**
* **AI-Based Fault Prediction Probability Graph**

---

## ▶️ How to Run the Project

1. Open MATLAB
2. Place the `.m` file in the MATLAB working directory
3. Run the script:

   ```matlab
   smart_digital_twin
   ```
4. Enter the input voltage when prompted
5. Observe outputs and plots

---

## 🚀 Applications

* Predictive maintenance demonstration
* Digital Twin concept learning
* Academic mini/major projects
* Internship technical submission
* Industry 4.0 simulations

---

## 🔮 Future Enhancements

* Integration with real-time sensor data
* Machine learning-based prediction model
* Data logging and trend analysis
* IoT and cloud dashboard integration

---

## 👤 Author

**Amol Gulhane**
Electronics & Telecommunication Engineering
Shri Sant Gajanan Maharaj College of Engineering, Shegaon

---

## 📜 License

This project is intended for **academic and learning purposes only**.

---

⭐ If you find this project helpful, consider starring the repository!
