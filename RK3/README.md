### RUNGE KUTTA THIRD ORDER ODE SOLVERS ###

The RK3 method improves upon the RK2 method by taking an additional intermediate step, resulting in higher accuracy. The formulas for solving an equation using the RK3 method are:

k<sub>1</sub>​=h⋅f(x<sub>n​</sub>,y<sub>n</sub>​);

k<sub>2</sub>​=h⋅f(x<sub>n</sub>​+h/2 ​,y<sub>n​</sub>+k1/2​​);

k<sub>3</sub>​=h⋅f(t<sub>n</sub>​+h,y<sub>n</sub>​−k<sub>1​</sub>+2k<sub>2</sub>​)

x<sub>n+1</sub> = x<sub>n</sub> + h;

y<sub>n+1</sub>​=y<sub>n​</sub>+1/6​(k<sub>1</sub>​+4k<sub>2</sub>​+k<sub>3​</sub>)+O(h<sup>4</sup>)


***Implementation***

At first, we had specified one ODE which is pretty much simple to approximate the solution using RK methods. The ODE is as follows:

f = x<sup>2</sup> - y<sup>2</sup>

The hardware accelerator design has been mentioned in the ![paper](https://ieeexplore.ieee.org/document/10442325). Please go and check it out. 

The hardware accelerator has been created to implement the RK3 method for solving differential equations efficiently. It utilizes four custom instructions: RKI initializes parameters, RKF flushes parameters to the RK4 module, RKU updates and saves results, and RKS stores results in memory. Parameters, such as 𝑥<sub>𝑖𝑛</sub>, 𝑦<sub>𝑖𝑛</sub>, ℎ, ℎ/2, ℎ/6, and p1_in, are stored in memory addresses 0 to 20. RKU updates and saves results to mem[0] and mem[4] for 𝑥<sub>𝑛+1</sub> and 𝑦<sub>𝑛+1</sub>, respectively. Finally, RKS stores results in new memory addresses, facilitating the efficient execution of the RK4 method for differential equation solving.

***Results***

**On-Chip Power**

For the third order RK hardware accelerator, the estimated power is 0.324W for 100Mhz clock frequency. The dynamic power usage is 67% and static power usage is 33% for the RK3 method.
A comparison along with the other methods for solving the ODE using third and fourth-order RK methods has been represented by the following image:

![On_Chip_Power_Consumption](On_chip_power.png)
![Power_Utilization_Sources_Percentage](Power_utilization_sources.jpeg)

**FPGA Resources**

All the hardware utilization resources of the hardware accelerator design such as look-up tables usages for the designs distributed RAM (LUTRAM), which means the LUTs can be used as synchronous RAM, flip-flops (FF), multipliers (DSP), input outputs (IO), high fanout buffer (BUFG), have been shown using a bar chart representation, given in ![fpga_resource](FPGA_Resource_Utilization.png).

**Timing Summary**

A comparison of the timing summary has been given below:

| Accelerators  |Setup Time (Max)(ns) |Setup Time (Min)(ns)  |Hold Time(max)    |Hold Time (Min) |  
| --------------| --------------------|----------------------|------------------|----------------|
| RK2           | 3.100               |2.810                 |0.554             |0.197           |
| RK3           | 3.699               |3.401                 |0.410             |0.345           |   
| RK4           | 3.935               |3.661                 |0.024             |0.052           |

In this study, the accelerator for the third Runge Kutta ODE solvers has been designed and implemented. A comparative analysis of the power, hardware resource utilization, and timing summary has been provided for all the hardware accelerators designed. All the work has been done using VHDL language in the Xilinx Vivado Environment and deployed on the Zynq-ZC702 FPGA Evaluation Board. It has been seen that the hardware accelerator runs more efficiently using the Xilinx Vivado single-precision floating point IP support.


