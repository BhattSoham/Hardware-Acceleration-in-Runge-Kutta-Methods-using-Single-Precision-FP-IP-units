### RUNGE KUTTA FOURTH ORDER ODE SOLVER ###

Runge Kutta fourth order differential equation solver method or RK4 method is used to approximate the value of ‘y’ with a given value of ‘x’. RK4 methods are generally used to solve the initial-value problems of differential equations. The formulas for solving an equation using the RK4 method are:

k<sub>1</sub>​=h⋅f(x<sub>n​</sub>,y<sub>n</sub>​);

𝐾<sub>2</sub> = 𝑓(𝑥<sub>𝑛</sub> + ℎ/2, 𝑦<sub>𝑛</sub> + ℎ𝐾<sub>1</sub> /2) 

𝐾<sub>3</sub> = 𝑓(𝑥<sub>𝑛</sub> + ℎ/2, 𝑦<sub>𝑛</sub> + ℎ𝐾<sub>2</sub> /2) 

𝐾<sub>4</sub> = 𝑓(𝑥<sub>𝑛</sub> + ℎ, 𝑦<sub>𝑛</sub> + ℎ𝐾<sub>3</sub> ) 

x<sub>n+1</sub> = x<sub>n</sub> + h;

𝑦 <sub>𝑛+1</sub> = 𝑦<sub>𝑛</sub> + (ℎ/6)(𝐾<sub>1</sub> + 2𝐾<sub>2</sub> + 2𝐾<sub>3</sub> + 𝐾<sub>4</sub> ) + 𝑂(ℎ<sup>5</sup>)

The value of ‘n’ varies from 0 to (𝑥 − x<sub>0</sub> )/ℎ and ‘h’ is the step size.


***Implementation***

At first, we had specified one ODE which is pretty much simple to approximate the solution using RK methods. The ODE is as follows:

f = x<sup>2</sup> - y<sup>2</sup>

The hardware accelerator design has been mentioned in the ![paper](https://ieeexplore.ieee.org/document/10442325). Please go and check it out. 

The hardware accelerator has been created to implement the RK4 method for solving differential equations efficiently. It utilizes four custom instructions: RKI initializes parameters, RKF flushes parameters to the RK3 module, RKU updates and saves results, and RKS stores results in memory. Parameters, such as 𝑥<sub>𝑖𝑛</sub>, 𝑦<sub>𝑖𝑛</sub>, ℎ, ℎ/2, ℎ/6, and p1_in, are stored in memory addresses 0 to 20. RKU updates and saves results to mem[0] and mem[4] for 𝑥<sub>𝑛+1</sub> and 𝑦<sub>𝑛+1</sub>, respectively. Finally, RKS stores results in new memory addresses, facilitating the efficient execution of the RK3 method for differential equation solving.

***Results***

**On-Chip Power Consumption**

For the fourth order RK hardware accelerator, the estimated power is 0.367W for 100Mhz clock frequency. The dynamic power usage is 71% and static power usage is 29% for the RK3 method. The
experimental results show that the fourth-order Runge-Kutta equation consumes a substantial amount of power; it increases by an estimated 51.37 percent
when using second-order solvers and 12.445 percent when using third-order solvers at a 100 MHz clock rate.
A comparison along with the other methods for solving the ODE using second and third-order RK methods has been represented by the following image:

![On_Chip_Power_Consumption](/On_chip_power.png)

![Power_Utilization_Sources_Percentage](/Power_utilization_sources.jpeg)

**FPGA Resources**

All the hardware utilization resources of the hardware accelerator design such as look-up tables usages for the designs distributed RAM (LUTRAM), which means the LUTs can be used as synchronous RAM, flip-flops (FF), multipliers (DSP), input outputs (IO), high fanout buffer (BUFG), have been shown using a bar chart representation, given in ![fpga_resource](/FPGA_Resource_Utilization.png).

**Timing Summary**

A comparison of the timing summary has been given below:

| Accelerators  |Setup Time (Max)(ns) |Setup Time (Min)(ns)  |Hold Time(max)    |Hold Time (Min) |  
| --------------| --------------------|----------------------|------------------|----------------|
| RK2           | 3.100               |2.810                 |0.554             |0.197           |
| RK3           | 3.699               |3.401                 |0.410             |0.345           |   
| RK4           | 3.935               |3.661                 |0.024             |0.052           |

In this study, the accelerator for the third Runge Kutta ODE solver has been designed and implemented. A comparative analysis of the power, hardware resource utilization, and timing summary has been provided for all the hardware accelerators designed. All the work has been done using VHDL language in the Xilinx Vivado Environment and deployed on the Zynq-ZC702 FPGA Evaluation Board. It has been seen that the hardware accelerator runs more efficiently using the Xilinx Vivado single-precision floating point IP support.


