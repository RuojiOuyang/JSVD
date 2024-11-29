#include "BlockParallel/BlockParallel.h"
#include "Serial/Serial.h"
#include "Parallel/Parallel.h"
#include "Matrix/Matrix.h"

#include <stdlib.h>
#include <iostream>
#include <sys/time.h>
#include <stdlib.h>
#include <omp.h>
#include <cmath>
#include <algorithm>

using namespace std;

int main()
{
  timeval t_start, t_end;
  double threshold = 1e-5;
  int N = 400;

    cout << "==========The Number of Thread is: " 
         << NUM_THREADS << "==========" <<endl;
    double test[N*N] = {0};
    double A[N*N] = {0};
    double V[N*N] = {0};
    double U[N*N] = {0};
    double sigma[N] = {0};
    Matrix::random_vec(test,N);

    Matrix::reset_vec(test, A, N);
    Matrix::reset_vec(A, U, N);
    Matrix::identity_vec(V, N);

    BlockParallel block_parallel;
    gettimeofday(&t_start, NULL);
    block_parallel.SVD(A, U, V, N, threshold, sigma);
    gettimeofday(&t_end, NULL);

    cout << "Block Parallel SVD time cost: "
         << 1000 * (t_end.tv_sec - t_start.tv_sec) +
            0.001 * (t_end.tv_usec - t_start.tv_usec) << "ms" << endl;
  return 0;
}