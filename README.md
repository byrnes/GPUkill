# GPUkill
A simple PowerShell script to kill programs running on an Nvidia GPU. I use this to kill programs that have been started when a monitor was connected to the dGPU and the monitor has been disconnected. This won't kill DWM, because it stops on the GPU running when all other programs running on the GPU do. The included autohotkey script remaps insert to run the script. 
