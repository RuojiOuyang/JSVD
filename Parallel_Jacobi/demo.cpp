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
  int NUM_THREADS = 4;
  double threshold = 1e-5;

  for (int N = 50; N <= 400; N = N+50)
  {
    cout << "==========The Size of Matrix is: " 
         << N << "==========" <<endl;
    double test[N*N] = {0};
    double A[N*N] = {0};
    double V[N*N] = {0};
    double U[N*N] = {0};
    double sigma[N] = {0};
    Matrix::random_vec(test,N);

    Matrix::reset_vec(test, A, N);
    Matrix::reset_vec(A, U, N);
    Matrix::identity_vec(V, N);

    Serial serial;
    gettimeofday(&t_start, NULL);
    serial.SVD(A, U, V, N, threshold, sigma);
    gettimeofday(&t_end, NULL);

    cout << "Serial SVD time cost: "
         << 1000 * (t_end.tv_sec - t_start.tv_sec) +
            0.001 * (t_end.tv_usec - t_start.tv_usec) << "ms" << endl;

    Matrix::reset_vec(test, A, N);
    Matrix::reset_vec(A, U, N);
    Matrix::identity_vec(V, N);

    Parallel parallel;
    gettimeofday(&t_start, NULL);
    parallel.SVD(A, U, V, N, threshold, sigma);
    gettimeofday(&t_end, NULL);

    cout << "Parallel SVD time cost: "
         << 1000 * (t_end.tv_sec - t_start.tv_sec) +
            0.001 * (t_end.tv_usec - t_start.tv_usec) << "ms" << endl;

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
  }
    return 0;
}