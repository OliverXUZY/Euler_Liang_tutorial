#!/usr/bin/env bash
#
#SBATCH --output=./log/l_%j.log
#SBATCH --error=./log/e_%j.log
#***SBATCH --partition=batch_default ***
# 
# 1 node, 1 CPU per node (total 1 CPU), wall clock time of hours
#
#SBATCH -N 1                  ## Node count
#SBATCH --ntasks-per-node=3   ## Processors per node
#SBATCH --ntasks=1             ## Tasks
#SBATCH --gres=gpu:1          ## GPUs
#SBATCH --cpus-per-task=3     ## CPUs per task; number of threads of each task
#SBATCH -t 256:00:00          ## Walltime
#SBATCH --mem=20GB
#SBATCH -p ppc
cd /srv/home/zhmeishi/robust/euler
source ~/.bashrc_wml
python run_file --conf ./conf/yamlname.yaml