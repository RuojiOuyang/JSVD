#ifndef JACOBISVD_MATRIX_H
#define JACOBISVD_MATRIX_H

#include "../common.h"

class Matrix
{
public:
    static void print_vec(double vec[], int N);
    static void random_vec(double vec[], int N);
    static void reset_vec(double src[], double dst[], int N);
    static void identity_vec(double vec[], int N);
};


#endif //JACOBISVD_MATRIX_H
