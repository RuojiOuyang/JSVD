# JacobiSVD

### Tree

```bash
.
├── BlockParallel # Block Parallel Jacobi
│   ├── BlockParallel.cpp # Include Jacobi Rotation and One-sided Jacobi SVD
│   └── BlockParallel.h 
├── CMakeLists.txt # CMake
├── common.h # Set some parameters
├── demo.cpp # demo function
├── main.cpp # main function
├── Core_test.cpp # test_parallel function
├── Matrix # Matrix with simple operation
│   ├── Matrix.cpp 
│   └── Matrix.h 
├── Parallel # Direct Parallel Jacobi
│   ├── Parallel.cpp # Include Jacobi Rotation and One-sided Jacobi SVD
│   └── Parallel.h 
├── Serial # Serial Jacobi
│   ├── Serial.cpp # Include Jacobi Rotation and One-sided Jacobi SVD
│   └── Serial.h 
└── build # where you should using cmake
```

### Usage

**Create a build directory**: Create a new build directory in the root directory of the project.

```bash
mkdir build
```

**Enter the build directory**: Enter the build directory you just created.

```bash
cd build
```

**Run CMake configuration**: Run the CMake command in the build directory, specifying the source code directory.

```bash
cmake ..
```

**Compile and build**: Compile and build with the generated build files.

```bash
make
```

