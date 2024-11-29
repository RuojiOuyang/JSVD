<center>JSVD

### Description: 

JacobiSVD is a package for computing the singular value decomposition (SVD) of general dense matrices using Jacobi algorithms. The advantage of the Jacobi scheme is the higher accuracy of the computed singular values (compared to QR and divide-and-conquer algorithms). The disadvantage is that they are relatively inefficient unless one combines them with elaborate preconditioning. 

### Modules and Features

- Common effective preprocessing methods are implemented to speed up the algorithm
- Parallel code with a better parallelism scheme 
- Quaternion SVD was successfully implemented in parallel

### Kind reminder

our code is written based on:

- MATLAB toolbox QTFM for quaternions: https://qtfm.sourceforge.io/
- MATLAB Parallel Computing Toolbox: [Parallel Computing Toolbox - MATLAB](https://ww2.mathworks.cn/products/parallel-computing.html)
- OpenMP: [Home - OpenMP](https://www.openmp.org/)

