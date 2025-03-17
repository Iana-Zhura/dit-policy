

### 1. PIP Installationa failure when building the env:

- **SOLUTIONS**:
    - comment out following pkgs in `env.yml`
        ```yml
        # - hydra-ray-launcher==1.2.0
        # - hydra-core==1.2.0
        # - hydra-submitit-launcher==1.2.0
        ```

    - Install them later. But u will face more issues 
        - crypt.h:  No such file or directory

---

### 2. `crypt.h:  No such file or directory` when installing `hydra-ray-launcher==1.2.0`:

- **SOLUTIONS**:
    - The error happens when it installs `pickle5` dependency.
    - Install libcrypt:
        - ```sudo apt-get install libcrypt-dev```
    - Install pickle5:
        - check crypt.h is located: `find /usr/include -name "crypt.h"`
        - copy it to the conda env's include dir:  `cp /usr/include//crypt.h ~/miniconda3/envs/data4robotics2/include/`

    - If `cannot find /usr/lib64/libpthread_nonshared.a:` error occur;
        - `CC=/usr/bin/gcc pip install pickle5`

    - then install `hydra-ray-launcher`: `pip install hydra-ray-launcher==1.2.0`

    - after that install `hydra-core==1.2.0` and `hydra-submitit-launcher==1.2.0`

    - then install the mentioned pkgs in git repo:
        ```bash
        cd dit-policy
        pip install git+https://github.com/AGI-Labs/robobuf.git
        pip install git+https://github.com/facebookresearch/r3m.git
        pip install -e ./
        ```

---

### 3. Check pytorch works with cuda 11.8

- check: ```python -c "import torch; print(torch.version.cuda)"```
- if output is `11.8` everything is ok.
- if u get an error
    ```bash
    ImportError: /home/zhura/miniconda3/envs/env_dit/lib/python3.9/site-packages/torch/lib/libtorch_cpu.so: undefined symbol: iJIT_NotifyEvent
    ```

    then do:

    ```bash
    pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
    ```

---


### 4. GL/gl.h not found

- install: ```sudo apt install mesa-common-dev libgl1-mesa-dev libglu1-mesa-dev freeglut3-dev```
- find: ```find /usr -name "gl.h"```
- copy gl.h lib to conda env.: 
    ```bash
    cp /usr/include/GL/gl.h ~/miniconda3/envs/data4robotics/include/GL/
    ```

### 5. robosuite:
- only install 1.4.1 : ```pip install robosuite==1.4.1```


### 6. Robosuite warnings:
```bash
[robosuite WARNING] No private macro file found! (macros.py:53)
[robosuite WARNING] It is recommended to use a private macro file (macros.py:54)
```
- **SOLUTION**:
    - No private macro file found: This means the system couldn't find a macros.py file, which may be used to store customized macros or settings.
        - You can generate this file by running
            ```bash
            python /home/zhura/miniconda3/envs/data4robotics/lib/python3.9/site-packages/robosuite/scripts/setup_macros.py
            ```
        - this will solve both warnings

### 7. To install mujoco follow this guide
 - https://gist.github.com/saratrajput/60b1310fe9d9df664f9983b38b50d5da

### 8. No module found robosuite.utils:
 - Add to finetune.py ```import robosuite.utils```