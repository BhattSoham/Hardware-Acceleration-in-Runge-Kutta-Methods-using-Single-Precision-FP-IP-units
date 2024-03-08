### RUNGE KUTTA SECOND ORDER ODE SOLVERS ###

The RK2 method is a simple but effective numerical technique for solving ODEs. It involves taking two intermediate steps to approximate the solution at the next time step. The formulas for solving an equation using the RK2 method are:

k<sub>1</sub>​=h⋅f(x<sub>n​</sub>,y<sub>n</sub>​);

k<sub>2</sub>​=h⋅f(x<sub>n</sub>​+h/2 ​,y<sub>n​</sub>+k1/2​​)

x<sub>n+1</sub> = x<sub>n</sub> + h;

y<sub>n+1</sub>​=y<sub>n​</sub>+k<sub>2</sub>​+O(h<sup>3</sup>)

***Implementation***

At first, we had specified one ODE which is pretty much simple to approximate the solution using RK methods. The ODE is as follows:

f = x<sup>2</sup> - y<sup>2</sup>

The hardware accelerator design has been mentioned in the ![paper](https://ieeexplore.ieee.org/document/10442325). Please go and check it out. 

The hardware accelerator has been created to implement the RK2 method for solving differential equations efficiently. It utilizes four custom instructions: RKI initializes parameters, RKF flushes parameters to the RK4 module, RKU updates and saves results, and RKS stores results in memory. Parameters, such as 𝑥<sub>𝑖𝑛</sub>, 𝑦<sub>𝑖𝑛</sub>, ℎ, ℎ/2, ℎ/6, and p1_in, are stored in memory addresses 0 to 20. RKU updates and saves results to mem[0] and mem[4] for 𝑥<sub>𝑛+1</sub> and 𝑦<sub>𝑛+1</sub>, respectively. Finally, RKS stores results in new memory addresses, facilitating the efficient execution of the RK4 method for differential equation solving.

***Results***

**On-Chip Power**
For the second order RK hardware accelerator, the estimated power is 0.217W for 100Mhz clock frequency. The dynamic power usage is 51% and static power usage is 49% for the RK2 method.

**FPGA Resources**
RK2 uses 4% and 

