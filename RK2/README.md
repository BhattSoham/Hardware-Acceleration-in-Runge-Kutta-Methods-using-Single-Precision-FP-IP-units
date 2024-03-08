### RUNGE KUTTA SECOND ORDER ODE SOLVER ###

The RK2 method is a simple but effective numerical technique for solving ODEs. It involves taking two intermediate steps to approximate the solution at the next time step. The formulas for solving an equation using the RK2 method are:

k<sub>1</sub>​=h⋅f(x<sub>n​</sub>,y<sub>n</sub>​);

k<sub>2</sub>​=h⋅f(x<sub>n</sub>​+h/2 ​,y<sub>n​</sub>+k1/2​​)

x<sub>n+1</sub> = x<sub>n</sub> + h;

y<sub>n+1</sub>​=y<sub>n​</sub>+k<sub>2</sub>​+O(h<sup>3</sup>)
