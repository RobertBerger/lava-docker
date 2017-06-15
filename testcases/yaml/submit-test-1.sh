HERE=$(pwd)
#./submit.py -k ${HERE}/apikey.txt --port 8000 kvm-qemu-aarch64.json
./submityaml.py -k ../apikey.txt --port 8000 -p qemu.yaml
