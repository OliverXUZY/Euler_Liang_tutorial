#!/usr/bin/env zsh
#
#SBATCH --output=./l_device_%j.log
#SBATCH --error=./e_device_%j.log
#***SBATCH --partition=batch_default ***
# 
# 1 node, 1 CPU per node (total 1 CPU), wall clock time of hours
#
#SBATCH -N 1                  ## Node count
#SBATCH --ntasks-per-node=4   ## Processors per node
#SBATCH --ntasks=1            ## Tasks
#SBATCH --gres=gpu:1          ## GPUs
#SBATCH --cpus-per-task=4     ## CPUs per task; number of threads of each task
#SBATCH -t 256:00:00          ## Walltime
#SBATCH --mem=20GB
#SBATCH -p lianglab
cd ~/Euler_Liang_tutorial
source ~/.zshrc
python train.py