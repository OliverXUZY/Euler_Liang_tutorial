import os
import argparse
import json

parser = argparse.ArgumentParser("Training model")

parser.add_argument('--ppc', action='store_true')
parser.add_argument('--liang', action='store_true')
parser.add_argument('--cpu', action='store_true')

args = parser.parse_args()
config_file_path = args.config
run_file = args.run
cpu = args.cpu

run_file = os.path.basename(run_file)

config_file = os.path.basename(config_file_path)[:-5]
conf_type = os.path.basename(config_file_path)[-4:]

assert("raw" not in config_file)
if run_file == "main.py":
    read_file = "./script/raw.sh"
else:
    raise("File is not defined")

f = open(read_file)
text = f.read()
f.close()
if args.liang:
    text = text.replace(
        "#SBATCH -p ppc", "#SBATCH -p lianglab \n#SBATCH --qos=lianglab_owner")
elif not args.ppc:
    text = text.replace("#SBATCH -p ppc", "")
if cpu:
    text = text.replace("#SBATCH --gres=gpu:1          ## GPUs", "")

path = "./script/"+config_file+".sh"

text = text.replace("run_file", run_file)
text = text.replace("yamlname", config_file)

f = open(path, "w")
f.write(text)
f.close()

if not os.path.exists("exp"):
    os.makedirs("exp")
exp_path = os.path.join("exp", config_file)
if not os.path.exists(exp_path):
    os.makedirs(exp_path)
os.system("sbatch " + path)
