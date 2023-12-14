# buildx-errors
Demonstrate the error with docker buildx not being able to use an image exported with `--load`
* https://github.com/moby/buildkit/issues/4162
* https://github.com/docker/buildx/issues/2024
* https://stackoverflow.com/questions/74281175/docker-buildx-failing-to-find-local-docker-image
* https://stackoverflow.com/questions/74707530/docker-buildx-fails-to-show-result-in-image-list

The error can be reproduced by running the `reproduce.sh` script

## Logs from a build
```shell
% ./reproduce.sh            
container
[+] Building 1.9s (7/7) FINISHED                                                                                                     docker-container:container
 => [internal] booting buildkit                                                                                                                            0.9s
 => => pulling image moby/buildkit:buildx-stable-1                                                                                                         0.5s
 => => creating container buildx_buildkit_container0                                                                                                       0.4s
 => [internal] load build definition from base.dockerfile                                                                                                  0.0s
 => => transferring dockerfile: 91B                                                                                                                        0.0s
 => [internal] load metadata for docker.io/library/hello-world:latest                                                                                      0.7s
 => [internal] load .dockerignore                                                                                                                          0.0s
 => => transferring context: 2B                                                                                                                            0.0s
 => [1/1] FROM docker.io/library/hello-world:latest@sha256:3155e04f30ad5e4629fac67d6789f8809d74fea22d4e9a82f757d28cee79e0c5                                0.1s
 => => resolve docker.io/library/hello-world:latest@sha256:3155e04f30ad5e4629fac67d6789f8809d74fea22d4e9a82f757d28cee79e0c5                                0.0s
 => => sha256:70f5ac315c5af948332962ff4678084ebcc215809506e4b8cd9e509660417205 3.19kB / 3.19kB                                                             0.1s
 => exporting to docker image format                                                                                                                       0.1s
 => => exporting layers                                                                                                                                    0.0s
 => => exporting manifest sha256:9400d2c6d2b402f4a10d16ae45e4b2081f9f95fa0eb37df02df098f958379ee2                                                          0.0s
 => => exporting config sha256:4dacff6440bc6b7924cf75caf7133027e01fdcd46e86ca20d89384ba6dd6f53a                                                            0.0s
 => => sending tarball                                                                                                                                     0.0s
 => importing to docker                                                                                                                                    0.0s
[+] Building 0.3s (2/2) FINISHED                                                                                                     docker-container:container
 => [internal] load build definition from second.dockerfile                                                                                                0.0s
 => => transferring dockerfile: 91B                                                                                                                        0.0s
 => ERROR [internal] load metadata for docker.io/library/base:local                                                                                        0.3s
------
 > [internal] load metadata for docker.io/library/base:local:
------
WARNING: No output specified with docker-container driver. Build result will only remain in the build cache. To push result image into registry use --push or to load image into docker use --load
second.dockerfile:1
--------------------
   1 | >>> FROM base:local
   2 |     
   3 |     ENV SECOND_ENV_VAR="also set"
--------------------
ERROR: failed to solve: base:local: pull access denied, repository does not exist or may require authorization: server message: insufficient_scope: authorization failed

```
