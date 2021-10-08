#! /bin/bash
#SBATCH -J b_12_480
#SBATCH -N 12
#SBATCH -n 480
#SBATCH -t 00:20:00
#SBATCH --exclusive
#SBATCH -o mom6_N12_n480_%j.out
#SBATCH -e mom6_N12_n480_%j.err

module purge
module load netcdf/gcc/hdf5-1.8.16/openmpi-1.10.2/4.4.0
module load hdf5/gcc/openmpi-1.10.2/1.8.16
module load openmpi/gcc/1.10.2/64

echo \#DJL START `date`
srun  ../../build/gnu/ocean_only/debug/MOM6
echo \#DJL END `date`
