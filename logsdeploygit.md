Current runner version: '2.326.0'
Runner Image Provisioner
Operating System
Runner Image
GITHUB_TOKEN Permissions
Secret source: Actions
Prepare workflow directory
Prepare all required actions
Getting action download info
Download immutable action package 'actions/checkout@v4'
Download immutable action package 'docker/setup-buildx-action@v3'
Download immutable action package 'docker/login-action@v3'
Download immutable action package 'docker/metadata-action@v5'
Download immutable action package 'docker/build-push-action@v5'
Download action repository 'appleboy/ssh-action@v1.0.0' (SHA:55dabf81b49d4120609345970c91507e2d734799)
Complete job name: build-and-deploy
4s
Build container for action use: '/home/runner/work/_actions/appleboy/ssh-action/v1.0.0/Dockerfile'.
21s
Run actions/checkout@v4
Syncing repository: fernandinhomartins40/ultrabase-max
Getting Git version info
Temporarily overriding HOME='/home/runner/work/_temp/5b5fabe4-4042-4d6d-864b-7f09662a8f41' before making global git config changes
Adding repository directory to the temporary git global config as a safe directory
/usr/bin/git config --global --add safe.directory /home/runner/work/ultrabase-max/ultrabase-max
Deleting the contents of '/home/runner/work/ultrabase-max/ultrabase-max'
Initializing the repository
Disabling automatic garbage collection
Setting up auth
Fetching the repository
  /usr/bin/git -c protocol.version=2 fetch --no-tags --prune --no-recurse-submodules --depth=1 origin +4eebb47f8aed89192e5fadb2d444f629ae5085aa:refs/remotes/origin/main
  From https://github.com/fernandinhomartins40/ultrabase-max
   * [new ref]         4eebb47f8aed89192e5fadb2d444f629ae5085aa -> origin/main
Determining the checkout info
/usr/bin/git sparse-checkout disable
/usr/bin/git config --local --unset-all extensions.worktreeConfig
Checking out the ref
  /usr/bin/git checkout --progress --force -B main refs/remotes/origin/main
  Updating files:  21% (2731/12457)
  Updating files:  22% (2741/12457)
  Updating files:  23% (2866/12457)
  Updating files:  24% (2990/12457)
  Updating files:  25% (3115/12457)
  Updating files:  26% (3239/12457)
  Updating files:  27% (3364/12457)
  Updating files:  28% (3488/12457)
  Updating files:  29% (3613/12457)
  Updating files:  30% (3738/12457)
  Updating files:  31% (3862/12457)
  Updating files:  32% (3987/12457)
  Updating files:  33% (4111/12457)
  Updating files:  34% (4236/12457)
  Updating files:  35% (4360/12457)
  Updating files:  36% (4485/12457)
  Updating files:  37% (4610/12457)
  Updating files:  38% (4734/12457)
  Updating files:  39% (4859/12457)
  Updating files:  40% (4983/12457)
  Updating files:  41% (5108/12457)
  Updating files:  42% (5232/12457)
  Updating files:  43% (5357/12457)
  Updating files:  44% (5482/12457)
  Updating files:  45% (5606/12457)
  Updating files:  46% (5731/12457)
  Updating files:  47% (5855/12457)
  Updating files:  48% (5980/12457)
  Updating files:  49% (6104/12457)
  Updating files:  50% (6229/12457)
  Updating files:  51% (6354/12457)
  Updating files:  52% (6478/12457)
  Updating files:  53% (6603/12457)
  Updating files:  54% (6727/12457)
  Updating files:  55% (6852/12457)
  Updating files:  56% (6976/12457)
  Updating files:  57% (7101/12457)
  Updating files:  58% (7226/12457)
  Updating files:  59% (7350/12457)
  Updating files:  60% (7475/12457)
  Updating files:  61% (7599/12457)
  Updating files:  62% (7724/12457)
  Updating files:  63% (7848/12457)
  Updating files:  63% (7919/12457)
  Updating files:  64% (7973/12457)
  Updating files:  65% (8098/12457)
  Updating files:  66% (8222/12457)
  Updating files:  67% (8347/12457)
  Updating files:  68% (8471/12457)
  Updating files:  68% (8535/12457)
  Updating files:  69% (8596/12457)
  Updating files:  70% (8720/12457)
  Updating files:  71% (8845/12457)
  Updating files:  72% (8970/12457)
  Updating files:  73% (9094/12457)
  Updating files:  74% (9219/12457)
  Updating files:  75% (9343/12457)
  Updating files:  76% (9468/12457)
  Updating files:  76% (9494/12457)
  Updating files:  77% (9592/12457)
  Updating files:  78% (9717/12457)
  Updating files:  79% (9842/12457)
  Updating files:  80% (9966/12457)
  Updating files:  81% (10091/12457)
  Updating files:  82% (10215/12457)
  Updating files:  83% (10340/12457)
  Updating files:  84% (10464/12457)
  Updating files:  85% (10589/12457)
  Updating files:  86% (10714/12457)
  Updating files:  87% (10838/12457)
  Updating files:  88% (10963/12457)
  Updating files:  89% (11087/12457)
  Updating files:  90% (11212/12457)
  Updating files:  91% (11336/12457)
  Updating files:  92% (11461/12457)
  Updating files:  93% (11586/12457)
  Updating files:  94% (11710/12457)
  Updating files:  95% (11835/12457)
  Updating files:  96% (11959/12457)
  Updating files:  97% (12084/12457)
  Updating files:  98% (12208/12457)
  Updating files:  99% (12333/12457)
  Updating files: 100% (12457/12457)
  Updating files: 100% (12457/12457), done.
  Switched to a new branch 'main'
  branch 'main' set up to track 'origin/main'.
/usr/bin/git log -1 --format=%H
4eebb47f8aed89192e5fadb2d444f629ae5085aa
7s
Run docker/setup-buildx-action@v3
  
Docker info
  /usr/bin/docker version
  Client: Docker Engine - Community
   Version:           28.0.4
   API version:       1.48
   Go version:        go1.23.7
   Git commit:        b8034c0
   Built:             Tue Mar 25 15:07:16 2025
   OS/Arch:           linux/amd64
   Context:           default
  Server: Docker Engine - Community
   Engine:
    Version:          28.0.4
    API version:      1.48 (minimum version 1.24)
    Go version:       go1.23.7
    Git commit:       6430e49
    Built:            Tue Mar 25 15:07:16 2025
    OS/Arch:          linux/amd64
    Experimental:     false
   containerd:
    Version:          1.7.27
    GitCommit:        05044ec0a9a75232cad458027ca83437aae3f4da
   runc:
    Version:          1.2.5
    GitCommit:        v1.2.5-0-g59923ef
   docker-init:
    Version:          0.19.0
    GitCommit:        de40ad0
  /usr/bin/docker info
  Client: Docker Engine - Community
   Version:    28.0.4
   Context:    default
   Debug Mode: false
   Plugins:
    buildx: Docker Buildx (Docker Inc.)
      Version:  v0.25.0
      Path:     /usr/libexec/docker/cli-plugins/docker-buildx
    compose: Docker Compose (Docker Inc.)
      Version:  v2.36.2
      Path:     /usr/libexec/docker/cli-plugins/docker-compose
  Server:
   Containers: 0
    Running: 0
    Paused: 0
    Stopped: 0
   Images: 1
   Server Version: 28.0.4
   Storage Driver: overlay2
    Backing Filesystem: extfs
    Supports d_type: true
    Using metacopy: false
    Native Overlay Diff: false
    userxattr: false
   Logging Driver: json-file
   Cgroup Driver: systemd
   Cgroup Version: 2
   Plugins:
    Volume: local
    Network: bridge host ipvlan macvlan null overlay
    Log: awslogs fluentd gcplogs gelf journald json-file local splunk syslog
   Swarm: inactive
   Runtimes: io.containerd.runc.v2 runc
   Default Runtime: runc
   Init Binary: docker-init
   containerd version: 05044ec0a9a75232cad458027ca83437aae3f4da
   runc version: v1.2.5-0-g59923ef
   init version: de40ad0
   Security Options:
    apparmor
    seccomp
     Profile: builtin
    cgroupns
   Kernel Version: 6.11.0-1018-azure
   Operating System: Ubuntu 24.04.2 LTS
   OSType: linux
   Architecture: x86_64
   CPUs: 4
   Total Memory: 15.62GiB
   Name: pkrvmpptgkbjq6m
   ID: 591ab723-8f3f-4ea3-a40e-18c1c65b58e9
   Docker Root Dir: /var/lib/docker
   Debug Mode: false
   Username: githubactions
   Experimental: false
   Insecure Registries:
    ::1/128
    127.0.0.0/8
   Live Restore Enabled: false
Buildx version
Inspecting default docker context
Creating a new builder instance
Booting builder
  /usr/bin/docker buildx inspect --bootstrap --builder builder-28df2bc6-b156-4d00-96fc-920661691e2a
  #1 [internal] booting buildkit
  #1 pulling image moby/buildkit:buildx-stable-1
  #1 pulling image moby/buildkit:buildx-stable-1 4.9s done
  #1 creating container buildx_buildkit_builder-28df2bc6-b156-4d00-96fc-920661691e2a0
  #1 creating container buildx_buildkit_builder-28df2bc6-b156-4d00-96fc-920661691e2a0 0.2s done
  #1 DONE 5.1s
  Name:          builder-28df2bc6-b156-4d00-96fc-920661691e2a
  Driver:        docker-container
  Last Activity: 2025-07-24 23:31:50 +0000 UTC
  Nodes:
  Name:                  builder-28df2bc6-b156-4d00-96fc-920661691e2a0
  Endpoint:              unix:///var/run/docker.sock
  Status:                running
  BuildKit daemon flags: --allow-insecure-entitlement security.insecure --allow-insecure-entitlement network.host
  BuildKit version:      v0.22.0
  Platforms:             linux/amd64, linux/amd64/v2, linux/amd64/v3, linux/386
  Labels:
   org.mobyproject.buildkit.worker.executor:         oci
   org.mobyproject.buildkit.worker.hostname:         d827676ae80f
   org.mobyproject.buildkit.worker.network:          host
   org.mobyproject.buildkit.worker.oci.process-mode: sandbox
   org.mobyproject.buildkit.worker.selinux.enabled:  false
   org.mobyproject.buildkit.worker.snapshotter:      overlayfs
  GC Policy rule#0:
   All:            false
   Filters:        type==source.local,type==exec.cachemount,type==source.git.checkout
   Keep Duration:  48h0m0s
   Max Used Space: 488.3MiB
  GC Policy rule#1:
   All:            false
   Keep Duration:  1440h0m0s
   Reserved Space: 7.451GiB
   Max Used Space: 54.02GiB
   Min Free Space: 13.97GiB
  GC Policy rule#2:
   All:            false
   Reserved Space: 7.451GiB
   Max Used Space: 54.02GiB
   Min Free Space: 13.97GiB
  GC Policy rule#3:
   All:            true
   Reserved Space: 7.451GiB
   Max Used Space: 54.02GiB
   Min Free Space: 13.97GiB
Inspect builder
  {
    "nodes": [
      {
        "name": "builder-28df2bc6-b156-4d00-96fc-920661691e2a0",
        "endpoint": "unix:///var/run/docker.sock",
        "status": "running",
        "buildkitd-flags": "--allow-insecure-entitlement security.insecure --allow-insecure-entitlement network.host",
        "buildkit": "v0.22.0",
        "platforms": "linux/amd64,linux/amd64/v2,linux/amd64/v3,linux/386",
        "features": {
          "Automatically load images to the Docker Engine image store": true,
          "Cache export": true,
          "Direct push": true,
          "Docker exporter": true,
          "Multi-platform build": true,
          "OCI exporter": true
        },
        "labels": {
          "org.mobyproject.buildkit.worker.executor": "oci",
          "org.mobyproject.buildkit.worker.hostname": "d827676ae80f",
          "org.mobyproject.buildkit.worker.network": "host",
          "org.mobyproject.buildkit.worker.oci.process-mode": "sandbox",
          "org.mobyproject.buildkit.worker.selinux.enabled": "false",
          "org.mobyproject.buildkit.worker.snapshotter": "overlayfs"
        },
        "gcPolicy": [
          {
            "all": false,
            "filter": [
              "type==source.local",
              "type==exec.cachemount",
              "type==source.git.checkout"
            ],
            "keepDuration": "48h0m0s",
            "maxUsedSpace": "488.3MiB"
          },
          {
            "all": false,
            "keepDuration": "1440h0m0s",
            "reservedSpace": "7.451GiB",
            "maxUsedSpace": "54.02GiB",
            "minFreeSpace": "13.97GiB"
          },
          {
            "all": false,
            "reservedSpace": "7.451GiB",
            "maxUsedSpace": "54.02GiB",
            "minFreeSpace": "13.97GiB"
          },
          {
            "all": true,
            "reservedSpace": "7.451GiB",
            "maxUsedSpace": "54.02GiB",
            "minFreeSpace": "13.97GiB"
          }
        ]
      }
    ],
    "name": "builder-28df2bc6-b156-4d00-96fc-920661691e2a",
    "driver": "docker-container",
    "lastActivity": "2025-07-24T23:31:50.000Z"
  }
BuildKit version
  
0s
Run docker/login-action@v3
  
Logging into ghcr.io...
Login Succeeded!
1s
Run docker/metadata-action@v5
  
Context info
Processing images input
Processing tags input
Processing flavor input
Docker image version
Docker tags
Docker labels
Annotations
JSON output
Bake file definition (tags)
Bake file definition (labels)
Bake file definition (annotations)
  
6m 14s
Run docker/build-push-action@v5
  
GitHub Actions runtime token ACs
Docker info
  /usr/bin/docker version
  Client: Docker Engine - Community
   Version:           28.0.4
   API version:       1.48
   Go version:        go1.23.7
   Git commit:        b8034c0
   Built:             Tue Mar 25 15:07:16 2025
   OS/Arch:           linux/amd64
   Context:           default
  Server: Docker Engine - Community
   Engine:
    Version:          28.0.4
    API version:      1.48 (minimum version 1.24)
    Go version:       go1.23.7
    Git commit:       6430e49
    Built:            Tue Mar 25 15:07:16 2025
    OS/Arch:          linux/amd64
    Experimental:     false
   containerd:
    Version:          1.7.27
    GitCommit:        05044ec0a9a75232cad458027ca83437aae3f4da
   runc:
    Version:          1.2.5
    GitCommit:        v1.2.5-0-g59923ef
   docker-init:
    Version:          0.19.0
    GitCommit:        de40ad0
  /usr/bin/docker info
  Client: Docker Engine - Community
   Version:    28.0.4
   Context:    default
   Debug Mode: false
   Plugins:
    buildx: Docker Buildx (Docker Inc.)
      Version:  v0.25.0
      Path:     /usr/libexec/docker/cli-plugins/docker-buildx
    compose: Docker Compose (Docker Inc.)
      Version:  v2.36.2
      Path:     /usr/libexec/docker/cli-plugins/docker-compose
  Server:
   Containers: 1
    Running: 1
    Paused: 0
    Stopped: 0
   Images: 2
   Server Version: 28.0.4
   Storage Driver: overlay2
    Backing Filesystem: extfs
    Supports d_type: true
    Using metacopy: false
    Native Overlay Diff: false
    userxattr: false
   Logging Driver: json-file
   Cgroup Driver: systemd
   Cgroup Version: 2
   Plugins:
    Volume: local
    Network: bridge host ipvlan macvlan null overlay
    Log: awslogs fluentd gcplogs gelf journald json-file local splunk syslog
   Swarm: inactive
   Runtimes: io.containerd.runc.v2 runc
   Default Runtime: runc
   Init Binary: docker-init
   containerd version: 05044ec0a9a75232cad458027ca83437aae3f4da
   runc version: v1.2.5-0-g59923ef
   init version: de40ad0
   Security Options:
    apparmor
    seccomp
     Profile: builtin
    cgroupns
   Kernel Version: 6.11.0-1018-azure
   Operating System: Ubuntu 24.04.2 LTS
   OSType: linux
   Architecture: x86_64
   CPUs: 4
   Total Memory: 15.62GiB
   Name: pkrvmpptgkbjq6m
   ID: 591ab723-8f3f-4ea3-a40e-18c1c65b58e9
   Docker Root Dir: /var/lib/docker
   Debug Mode: false
   Username: githubactions
   Experimental: false
   Insecure Registries:
    ::1/128
    127.0.0.0/8
   Live Restore Enabled: false
Proxy configuration
Buildx version
Builder info
  
/usr/bin/docker buildx build --cache-from type=gha --cache-to type=gha,mode=max --file ./Dockerfile --iidfile /home/runner/work/_temp/docker-actions-toolkit-5sA32m/build-iidfile-bf8e847af0.txt --label org.opencontainers.image.created=2025-07-24T23:31:57.050Z --label org.opencontainers.image.description= --label org.opencontainers.image.licenses=Apache-2.0 --label org.opencontainers.image.revision=4eebb47f8aed89192e5fadb2d444f629ae5085aa --label org.opencontainers.image.source=https://github.com/fernandinhomartins40/ultrabase-max --label org.opencontainers.image.title=ultrabase-max --label org.opencontainers.image.url=https://github.com/fernandinhomartins40/ultrabase-max --label org.opencontainers.image.version=main --attest type=provenance,mode=max,builder-id=https://github.com/fernandinhomartins40/ultrabase-max/actions/runs/16510048720 --tag ghcr.io/fernandinhomartins40/ultrabase-max:main --tag ghcr.io/fernandinhomartins40/ultrabase-max:sha-4eebb47 --metadata-file /home/runner/work/_temp/docker-acti
#0 building with "builder-28df2bc6-b156-4d00-96fc-920661691e2a" instance using docker-container driver
#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 2.45kB done
#1 DONE 0.0s
#2 [auth] library/node:pull token for registry-1.docker.io
#2 DONE 0.0s
#3 [internal] load metadata for docker.io/library/node:22-alpine
#3 DONE 0.4s
#4 [internal] load .dockerignore
#4 transferring context: 544B done
#4 DONE 0.0s
#5 [internal] load build context
#5 DONE 0.0s
#6 [base  1/11] FROM docker.io/library/node:22-alpine@sha256:5539840ce9d013fa13e3b9814c9353024be7ac75aca5db6d039504a56c04ea59
#6 resolve docker.io/library/node:22-alpine@sha256:5539840ce9d013fa13e3b9814c9353024be7ac75aca5db6d039504a56c04ea59 done
#6 DONE 0.0s
#7 importing cache manifest from gha:6901074614727013657
#7 DONE 0.1s
#6 [base  1/11] FROM docker.io/library/node:22-alpine@sha256:5539840ce9d013fa13e3b9814c9353024be7ac75aca5db6d039504a56c04ea59
#6 sha256:4f24e34311a053509408982697361a542fa36438d7203b25084c93609ad786c7 446B / 446B 0.0s done
#6 sha256:79a0252b29f675f95c0a6a239aee5f33aadcc8fd0e98a3d9812ac2f5310eb3a1 1.26MB / 1.26MB 0.1s done
#6 sha256:9824c27679d3b27c5e1cb00a73adb6f4f8d556994111c12db3c5d61a0c843df8 3.80MB / 3.80MB 0.1s done
#6 extracting sha256:9824c27679d3b27c5e1cb00a73adb6f4f8d556994111c12db3c5d61a0c843df8
#6 sha256:ccf5d6e6ff24e9c9ed711b95e9d910eab00d79142b0d9875d985aa1ee13e4f5b 6.80MB / 51.05MB 0.2s
#6 extracting sha256:9824c27679d3b27c5e1cb00a73adb6f4f8d556994111c12db3c5d61a0c843df8 0.1s done
#6 sha256:ccf5d6e6ff24e9c9ed711b95e9d910eab00d79142b0d9875d985aa1ee13e4f5b 32.51MB / 51.05MB 0.3s
#6 sha256:ccf5d6e6ff24e9c9ed711b95e9d910eab00d79142b0d9875d985aa1ee13e4f5b 51.05MB / 51.05MB 0.5s done
#6 extracting sha256:ccf5d6e6ff24e9c9ed711b95e9d910eab00d79142b0d9875d985aa1ee13e4f5b
#6 extracting sha256:ccf5d6e6ff24e9c9ed711b95e9d910eab00d79142b0d9875d985aa1ee13e4f5b 2.0s done
#6 extracting sha256:79a0252b29f675f95c0a6a239aee5f33aadcc8fd0e98a3d9812ac2f5310eb3a1 0.0s done
#6 extracting sha256:4f24e34311a053509408982697361a542fa36438d7203b25084c93609ad786c7 done
#6 DONE 2.5s
#8 [base  2/11] RUN npm install -g pnpm@9.15.5 &&     apk add --no-cache     curl     python3     make     g++     libc6-compat     vips-dev     cairo-dev     pango-dev     jpeg-dev     giflib-dev     librsvg-dev     pixman-dev     pangomm-dev     libjpeg-turbo-dev     freetype-dev     sqlite-dev     postgresql-dev
#8 2.934 
#8 2.934 added 1 package in 3s
#8 2.934 
#8 2.934 1 package is looking for funding
#8 2.934   run `npm fund` for details
#8 2.938 npm notice
#8 2.938 npm notice New major version of npm available! 10.9.2 -> 11.5.1
#8 2.938 npm notice Changelog: https://github.com/npm/cli/releases/tag/v11.5.1
#8 2.938 npm notice To update run: npm install -g npm@11.5.1
#8 2.938 npm notice
#8 3.076 fetch https://dl-cdn.alpinelinux.org/alpine/v3.22/main/x86_64/APKINDEX.tar.gz
#8 3.203 fetch https://dl-cdn.alpinelinux.org/alpine/v3.22/community/x86_64/APKINDEX.tar.gz
#8 3.718 (1/238) Installing cairo-tools (1.18.4-r0)
#8 3.732 (2/238) Installing libexpat (2.7.1-r0)
#8 3.741 (3/238) Installing brotli-libs (1.1.0-r2)
#8 3.762 (4/238) Installing libbz2 (1.0.8-r6)
#8 3.771 (5/238) Installing libpng (1.6.47-r0)
#8 3.780 (6/238) Installing freetype (2.13.3-r0)
#8 3.797 (7/238) Installing fontconfig (2.15.0-r3)
#8 3.827 (8/238) Installing expat (2.7.1-r0)
#8 3.838 (9/238) Installing pkgconf (2.4.3-r0)
#8 3.847 (10/238) Installing expat-dev (2.7.1-r0)
#8 3.859 (11/238) Installing bzip2-dev (1.0.8-r6)
#8 3.866 (12/238) Installing brotli (1.1.0-r2)
#8 3.877 (13/238) Installing brotli-dev (1.1.0-r2)
#8 3.896 (14/238) Installing zlib-dev (1.3.1-r2)
#8 3.907 (15/238) Installing libpng-dev (1.6.47-r0)
#8 3.916 (16/238) Installing freetype-dev (2.13.3-r0)
#8 3.940 (17/238) Installing fontconfig-dev (2.15.0-r3)
#8 3.949 (18/238) Installing libxau (1.0.12-r0)
#8 3.955 (19/238) Installing xorgproto (2024.1-r0)
#8 4.016 (20/238) Installing libxau-dev (1.0.12-r0)
#8 4.023 (21/238) Installing libmd (1.1.0-r0)
#8 4.031 (22/238) Installing libbsd (0.12.2-r0)
#8 4.040 (23/238) Installing libxdmcp (1.1.5-r1)
#8 4.047 (24/238) Installing libxcb (1.17.0-r0)
#8 4.069 (25/238) Installing libx11 (1.8.11-r0)
#8 4.129 (26/238) Installing libxext (1.3.6-r2)
#8 4.137 (27/238) Installing libffi (3.4.8-r0)
#8 4.145 (28/238) Installing gdbm (1.24-r0)
#8 4.159 (29/238) Installing xz-libs (5.8.1-r0)
#8 4.170 (30/238) Installing mpdecimal (4.0.1-r0)
#8 4.181 (31/238) Installing ncurses-terminfo-base (6.5_p20250503-r0)
#8 4.195 (32/238) Installing libncursesw (6.5_p20250503-r0)
#8 4.210 (33/238) Installing libpanelw (6.5_p20250503-r0)
#8 4.219 (34/238) Installing readline (8.2.13-r1)
#8 4.230 (35/238) Installing sqlite-libs (3.49.2-r1)
#8 4.254 (36/238) Installing python3 (3.12.11-r0)
#8 4.509 (37/238) Installing python3-pycache-pyc0 (3.12.11-r0)
#8 4.684 (38/238) Installing pyc (3.12.11-r0)
#8 4.684 (39/238) Installing xcb-proto-pyc (1.17.0-r0)
#8 4.700 (40/238) Installing python3-pyc (3.12.11-r0)
#8 4.700 (41/238) Installing xcb-proto (1.17.0-r0)
#8 4.716 (42/238) Installing libxdmcp-dev (1.1.5-r1)
#8 4.725 (43/238) Installing libxcb-dev (1.17.0-r0)
#8 4.752 (44/238) Installing xtrans (1.5.2-r0)
#8 4.770 (45/238) Installing libx11-dev (1.8.11-r0)
#8 4.782 (46/238) Installing libxext-dev (1.3.6-r2)
#8 4.797 (47/238) Installing libxrender (0.9.12-r0)
#8 4.805 (48/238) Installing libxrender-dev (0.9.12-r0)
#8 4.819 (49/238) Installing pixman (0.46.4-r0)
#8 4.836 (50/238) Installing pixman-dev (0.46.4-r0)
#8 4.848 (51/238) Installing util-macros (1.20.1-r0)
#8 4.857 (52/238) Installing xcb-util (0.4.1-r3)
#8 4.866 (53/238) Installing xcb-util-dev (0.4.1-r3)
#8 4.874 (54/238) Installing cairo (1.18.4-r0)
#8 4.891 (55/238) Installing libintl (0.24.1-r0)
#8 4.899 (56/238) Installing libeconf (0.6.3-r0)
#8 4.907 (57/238) Installing libblkid (2.41-r9)
#8 4.919 (58/238) Installing libmount (2.41-r9)
#8 4.929 (59/238) Installing pcre2 (10.43-r1)
#8 4.948 (60/238) Installing glib (2.84.3-r0)
#8 5.004 (61/238) Installing cairo-gobject (1.18.4-r0)
#8 5.011 (62/238) Installing libxml2 (2.13.8-r0)
#8 5.030 (63/238) Installing libxml2-utils (2.13.8-r0)
#8 5.037 (64/238) Installing docbook-xml (4.5-r10)
#8 5.089 Executing docbook-xml-4.5-r10.post-install
#8 5.108 (65/238) Installing libxslt (1.1.43-r3)
#8 5.127 (66/238) Installing docbook-xsl-ns (1.79.2-r11)
#8 5.372 Executing docbook-xsl-ns-1.79.2-r11.post-install
#8 5.623 (67/238) Installing docbook-xsl-nons (1.79.2-r11)
#8 6.145 Executing docbook-xsl-nons-1.79.2-r11.post-install
#8 6.191 (68/238) Installing docbook-xsl (1.79.2-r11)
#8 6.199 (69/238) Installing xz (5.8.1-r0)
#8 6.208 (70/238) Installing gettext-asprintf (0.24.1-r0)
#8 6.217 (71/238) Installing libunistring (1.3-r0)
#8 6.247 (72/238) Installing gettext-libs (0.24.1-r0)
#8 6.265 (73/238) Installing gettext-envsubst (0.24.1-r0)
#8 6.274 (74/238) Installing libgomp (14.2.0-r6)
#8 6.282 (75/238) Installing gettext (0.24.1-r0)
#8 6.326 (76/238) Installing gettext-dev (0.24.1-r0)
#8 6.352 (77/238) Installing py3-parsing (3.2.3-r0)
#8 6.364 (78/238) Installing py3-parsing-pyc (3.2.3-r0)
#8 6.375 (79/238) Installing py3-packaging (25.0-r0)
#8 6.392 (80/238) Installing py3-packaging-pyc (25.0-r0)
#8 6.404 (81/238) Installing linux-headers (6.14.2-r0)
#8 6.685 (82/238) Installing libffi-dev (3.4.8-r0)
#8 6.695 (83/238) Installing bsd-compat-headers (0.7.2-r6)
#8 6.702 (84/238) Installing libformw (6.5_p20250503-r0)
#8 6.709 (85/238) Installing libmenuw (6.5_p20250503-r0)
#8 6.727 (86/238) Installing libncurses++ (6.5_p20250503-r0)
#8 6.733 (87/238) Installing ncurses-dev (6.5_p20250503-r0)
#8 6.754 (88/238) Installing libedit (20250104.3.1-r1)
#8 6.763 (89/238) Installing libedit-dev (20250104.3.1-r1)
#8 6.777 (90/238) Installing libpcre2-16 (10.43-r1)
#8 6.790 (91/238) Installing libpcre2-32 (10.43-r1)
#8 6.804 (92/238) Installing pcre2-dev (10.43-r1)
#8 6.811 (93/238) Installing libuuid (2.41-r9)
#8 6.823 (94/238) Installing libfdisk (2.41-r9)
#8 6.831 (95/238) Installing liblastlog2 (2.41-r9)
#8 6.839 (96/238) Installing libsmartcols (2.41-r9)
#8 6.849 (97/238) Installing sqlite (3.49.2-r1)
#8 6.886 (98/238) Installing sqlite-dev (3.49.2-r1)
#8 6.918 (99/238) Installing util-linux-dev (2.41-r9)
#8 6.965 (100/238) Installing glib-dev (2.84.3-r0)
#8 7.079 (101/238) Installing cairo-dev (1.18.4-r0)
#8 7.108 (102/238) Installing c-ares (1.34.5-r0)
#8 7.124 (103/238) Installing libidn2 (2.3.7-r0)
#8 7.133 (104/238) Installing nghttp2-libs (1.65.0-r0)
#8 7.141 (105/238) Installing libpsl (0.21.5-r3)
#8 7.148 (106/238) Installing zstd-libs (1.5.7-r0)
#8 7.164 (107/238) Installing libcurl (8.14.1-r1)
#8 7.177 (108/238) Installing curl (8.14.1-r1)
#8 7.187 (109/238) Installing libstdc++-dev (14.2.0-r6)
#8 7.410 (110/238) Installing jansson (2.14.1-r0)
#8 7.419 (111/238) Installing binutils (2.44-r2)
#8 ...
#5 [internal] load build context
#5 transferring context: 993.64MB 10.0s
#5 ...
#8 [base  2/11] RUN npm install -g pnpm@9.15.5 &&     apk add --no-cache     curl     python3     make     g++     libc6-compat     vips-dev     cairo-dev     pango-dev     jpeg-dev     giflib-dev     librsvg-dev     pixman-dev     pangomm-dev     libjpeg-turbo-dev     freetype-dev     sqlite-dev     postgresql-dev
#8 7.588 (112/238) Installing libatomic (14.2.0-r6)
#8 7.595 (113/238) Installing gmp (6.3.0-r3)
#8 7.607 (114/238) Installing isl26 (0.26-r1)
#8 7.631 (115/238) Installing mpfr4 (4.2.1_p1-r0)
#8 7.644 (116/238) Installing mpc1 (1.3.1-r1)
#8 7.652 (117/238) Installing gcc (14.2.0-r6)
#8 ...
#9 [production 2/7] RUN npm install -g pnpm@9.15.5 &&     apk add --no-cache     curl     dumb-init     vips     cairo     pango     sqlite     postgresql-client
#9 2.947 
#9 2.947 added 1 package in 3s
#9 2.947 
#9 2.947 1 package is looking for funding
#9 2.947   run `npm fund` for details
#9 2.949 npm notice
#9 2.949 npm notice New major version of npm available! 10.9.2 -> 11.5.1
#9 2.949 npm notice Changelog: https://github.com/npm/cli/releases/tag/v11.5.1
#9 2.949 npm notice To update run: npm install -g npm@11.5.1
#9 2.949 npm notice
#9 3.077 fetch https://dl-cdn.alpinelinux.org/alpine/v3.22/main/x86_64/APKINDEX.tar.gz
#9 3.206 fetch https://dl-cdn.alpinelinux.org/alpine/v3.22/community/x86_64/APKINDEX.tar.gz
#9 3.774 (1/76) Installing libxau (1.0.12-r0)
#9 3.781 (2/76) Installing libmd (1.1.0-r0)
#9 3.790 (3/76) Installing libbsd (0.12.2-r0)
#9 3.798 (4/76) Installing libxdmcp (1.1.5-r1)
#9 3.806 (5/76) Installing libxcb (1.17.0-r0)
#9 3.836 (6/76) Installing libx11 (1.8.11-r0)
#9 3.919 (7/76) Installing libxext (1.3.6-r2)
#9 3.927 (8/76) Installing libxrender (0.9.12-r0)
#9 3.935 (9/76) Installing libexpat (2.7.1-r0)
#9 3.943 (10/76) Installing brotli-libs (1.1.0-r2)
#9 3.971 (11/76) Installing libbz2 (1.0.8-r6)
#9 3.979 (12/76) Installing libpng (1.6.47-r0)
#9 3.990 (13/76) Installing freetype (2.13.3-r0)
#9 4.018 (14/76) Installing fontconfig (2.15.0-r3)
#9 4.046 (15/76) Installing pixman (0.46.4-r0)
#9 4.064 (16/76) Installing cairo (1.18.4-r0)
#9 4.087 (17/76) Installing c-ares (1.34.5-r0)
#9 4.098 (18/76) Installing libunistring (1.3-r0)
#9 4.131 (19/76) Installing libidn2 (2.3.7-r0)
#9 4.141 (20/76) Installing nghttp2-libs (1.65.0-r0)
#9 4.154 (21/76) Installing libpsl (0.21.5-r3)
#9 4.162 (22/76) Installing zstd-libs (1.5.7-r0)
#9 4.182 (23/76) Installing libcurl (8.14.1-r1)
#9 4.197 (24/76) Installing curl (8.14.1-r1)
#9 4.210 (25/76) Installing dumb-init (1.2.5-r3)
#9 4.218 (26/76) Installing libxft (2.3.8-r3)
#9 4.227 (27/76) Installing fribidi (1.0.16-r1)
#9 4.237 (28/76) Installing libffi (3.4.8-r0)
#9 4.246 (29/76) Installing libintl (0.24.1-r0)
#9 4.256 (30/76) Installing libeconf (0.6.3-r0)
#9 4.265 (31/76) Installing libblkid (2.41-r9)
#9 4.275 (32/76) Installing libmount (2.41-r9)
#9 4.286 (33/76) Installing pcre2 (10.43-r1)
#9 4.300 (34/76) Installing glib (2.84.3-r0)
#9 4.370 (35/76) Installing graphite2 (1.3.14-r6)
#9 4.377 (36/76) Installing harfbuzz (11.2.1-r0)
#9 4.403 (37/76) Installing pango (1.56.3-r0)
#9 4.429 (38/76) Installing postgresql-common (1.2-r1)
#9 4.436 Executing postgresql-common-1.2-r1.pre-install
#9 4.457 (39/76) Installing lz4-libs (1.10.0-r0)
#9 4.467 (40/76) Installing libpq (17.5-r0)
#9 4.479 (41/76) Installing ncurses-terminfo-base (6.5_p20250503-r0)
#9 4.500 (42/76) Installing libncursesw (6.5_p20250503-r0)
#9 4.511 (43/76) Installing readline (8.2.13-r1)
#9 4.523 (44/76) Installing postgresql17-client (17.5-r0)
#9 4.585 (45/76) Installing sqlite (3.49.2-r1)
#9 4.611 (46/76) Installing openexr-libiex (3.3.2-r0)
#9 4.624 (47/76) Installing openexr-libilmthread (3.3.2-r0)
#9 4.632 (48/76) Installing imath (3.1.12-r0)
#9 4.644 (49/76) Installing libdeflate (1.23-r0)
#9 4.654 (50/76) Installing openexr-libopenexrcore (3.3.2-r0)
#9 4.681 (51/76) Installing openexr-libopenexr (3.3.2-r0)
#9 4.702 (52/76) Installing acl-libs (2.3.2-r1)
#9 4.711 (53/76) Installing xz-libs (5.8.1-r0)
#9 4.722 (54/76) Installing libarchive (3.8.1-r0)
#9 4.743 (55/76) Installing cfitsio (4.5.0-r0)
#9 4.760 (56/76) Installing cgif (0.5.0-r1)
#9 4.772 (57/76) Installing libexif (0.6.25-r0)
#9 4.785 (58/76) Installing fftw-double-libs (3.3.10-r6)
#9 4.811 (59/76) Installing libhwy (1.0.7-r1)
#9 4.817 (60/76) Installing libimagequant (4.2.2-r0)
#9 4.836 (61/76) Installing libjpeg-turbo (3.1.0-r0)
#9 4.855 (62/76) Installing lcms2 (2.16-r0)
#9 4.869 (63/76) Installing openjpeg (2.5.3-r0)
#9 4.881 (64/76) Installing libdav1d (1.5.1-r0)
#9 4.907 (65/76) Installing pkgconf (2.4.3-r0)
#9 4.921 (66/76) Installing libxml2 (2.13.8-r0)
#9 4.941 (67/76) Installing shared-mime-info (2.4-r6)
#9 4.958 (68/76) Installing libsharpyuv (1.5.0-r0)
#9 4.968 (69/76) Installing libwebp (1.5.0-r0)
#9 4.985 (70/76) Installing tiff (4.7.0-r0)
#9 4.997 (71/76) Installing gdk-pixbuf (2.42.12-r1)
#9 5.025 (72/76) Installing librsvg (2.60.0-r0)
#9 5.072 (73/76) Installing libspng (0.7.4-r1)
#9 5.082 (74/76) Installing libwebpdemux (1.5.0-r0)
#9 5.097 (75/76) Installing libwebpmux (1.5.0-r0)
#9 5.106 (76/76) Installing vips (8.16.1-r0)
#9 5.142 Executing busybox-1.37.0-r18.trigger
#9 5.151 Executing glib-2.84.3-r0.trigger
#9 5.156 Executing postgresql-common-1.2-r1.trigger
#9 5.160 * Setting postgresql17 as the default version
#9 5.272 WARNING: opening from cache https://dl-cdn.alpinelinux.org/alpine/v3.22/main: No such file or directory
#9 5.273 WARNING: opening from cache https://dl-cdn.alpinelinux.org/alpine/v3.22/community: No such file or directory
#9 5.282 Executing shared-mime-info-2.4-r6.trigger
#9 6.241 Executing gdk-pixbuf-2.42.12-r1.trigger
#9 6.266 OK: 60 MiB in 94 packages
#9 DONE 8.6s
#5 [internal] load build context
#5 ...
#10 [production 3/7] WORKDIR /app
#10 DONE 0.7s
#5 [internal] load build context
#5 ...
#11 [production 4/7] RUN addgroup -g 1001 -S nodejs &&     adduser -S nextjs -u 1001
#11 DONE 0.2s
#5 [internal] load build context
#5 transferring context: 1.50GB 15.1s
#5 transferring context: 2.16GB 20.2s
#5 transferring context: 2.18GB 20.4s done
#5 ...
#8 [base  2/11] RUN npm install -g pnpm@9.15.5 &&     apk add --no-cache     curl     python3     make     g++     libc6-compat     vips-dev     cairo-dev     pango-dev     jpeg-dev     giflib-dev     librsvg-dev     pixman-dev     pangomm-dev     libjpeg-turbo-dev     freetype-dev     sqlite-dev     postgresql-dev
#8 9.217 (118/238) Installing musl-dev (1.2.5-r10)
#8 9.320 (119/238) Installing g++ (14.2.0-r6)
#8 9.664 (120/238) Installing giflib (5.2.2-r1)
#8 9.672 (121/238) Installing giflib-dev (5.2.2-r1)
#8 9.684 (122/238) Installing libjpeg-turbo (3.1.0-r0)
#8 9.699 (123/238) Installing libturbojpeg (3.1.0-r0)
#8 9.715 (124/238) Installing libjpeg-turbo-dev (3.1.0-r0)
#8 9.727 (125/238) Installing jpeg-dev (9f-r0)
#8 9.727 (126/238) Installing musl-obstack (1.2.3-r2)
#8 9.734 (127/238) Installing libucontext (1.3.2-r0)
#8 9.742 (128/238) Installing gcompat (1.1.0-r4)
#8 9.750 (129/238) Installing libdav1d (1.5.1-r0)
#8 9.773 (130/238) Installing libxft (2.3.8-r3)
#8 9.781 (131/238) Installing fribidi (1.0.16-r1)
#8 9.792 (132/238) Installing graphite2 (1.3.14-r6)
#8 9.806 (133/238) Installing harfbuzz (11.2.1-r0)
#8 9.829 (134/238) Installing pango (1.56.3-r0)
#8 9.844 (135/238) Installing rsvg-convert (2.60.0-r0)
#8 9.881 (136/238) Installing shared-mime-info (2.4-r6)
#8 9.906 (137/238) Installing libsharpyuv (1.5.0-r0)
#8 9.912 (138/238) Installing libwebp (1.5.0-r0)
#8 9.926 (139/238) Installing tiff (4.7.0-r0)
#8 9.940 (140/238) Installing gdk-pixbuf (2.42.12-r1)
#8 9.957 (141/238) Installing librsvg (2.60.0-r0)
#8 10.00 (142/238) Installing dav1d-dev (1.5.1-r0)
#8 10.01 (143/238) Installing libtiffxx (4.7.0-r0)
#8 10.02 (144/238) Installing libwebpdecoder (1.5.0-r0)
#8 10.04 (145/238) Installing libwebpdemux (1.5.0-r0)
#8 10.05 (146/238) Installing libwebpmux (1.5.0-r0)
#8 10.05 (147/238) Installing libwebp-dev (1.5.0-r0)
#8 10.06 (148/238) Installing zstd (1.5.7-r0)
#8 10.07 (149/238) Installing zstd-dev (1.5.7-r0)
#8 10.09 (150/238) Installing tiff-dev (4.7.0-r0)
#8 10.10 (151/238) Installing gdk-pixbuf-dev (2.42.12-r1)
#8 10.11 (152/238) Installing harfbuzz-cairo (11.2.1-r0)
#8 10.11 (153/238) Installing harfbuzz-gobject (11.2.1-r0)
#8 10.12 (154/238) Installing icu-data-en (76.1-r1)
#8 10.15 Executing icu-data-en-76.1-r1.post-install
#8 10.15 *
#8 10.15 * If you need ICU with non-English locales and legacy charset support, install
#8 10.15 * package icu-data-full.
#8 10.15 *
#8 10.15 (155/238) Installing icu-libs (76.1-r1)
#8 10.20 (156/238) Installing harfbuzz-icu (11.2.1-r0)
#8 10.21 (157/238) Installing harfbuzz-subset (11.2.1-r0)
#8 10.23 (158/238) Installing graphite2-dev (1.3.14-r6)
#8 10.24 (159/238) Installing icu (76.1-r1)
#8 10.26 (160/238) Installing icu-dev (76.1-r1)
#8 10.32 (161/238) Installing harfbuzz-dev (11.2.1-r0)
#8 10.35 (162/238) Installing xz-dev (5.8.1-r0)
#8 10.36 (163/238) Installing libxml2-dev (2.13.8-r0)
#8 10.38 (164/238) Installing pango-tools (1.56.3-r0)
#8 10.39 (165/238) Installing fribidi-dev (1.0.16-r1)
#8 10.40 (166/238) Installing libxft-dev (2.3.8-r3)
#8 10.41 (167/238) Installing pango-dev (1.56.3-r0)
#8 10.43 (168/238) Installing librsvg-dev (2.60.0-r0)
#8 10.44 (169/238) Installing make (4.4.1-r3)
#8 10.45 (170/238) Installing libsigc++3 (3.6.0-r0)
#8 10.46 (171/238) Installing cairomm (1.18.0-r0)
#8 10.47 (172/238) Installing glibmm (2.84.0-r0)
#8 10.50 (173/238) Installing pangomm (2.54.0-r0)
#8 10.51 (174/238) Installing libsigc++3-dev (3.6.0-r0)
#8 10.53 (175/238) Installing cairomm-dev (1.18.0-r0)
#8 10.55 (176/238) Installing glibmm-dev (2.84.0-r0)
#8 10.64 (177/238) Installing pangomm-dev (2.54.0-r0)
#8 10.66 (178/238) Installing libpq (17.5-r0)
#8 10.67 (179/238) Installing openssl-dev (3.5.1-r0)
#8 10.71 (180/238) Installing libpq-dev (17.5-r0)
#8 10.74 (181/238) Installing libecpg (17.5-r0)
#8 10.75 (182/238) Installing libecpg-dev (17.5-r0)
#8 10.77 (183/238) Installing clang18-headers (18.1.8-r5)
#8 10.87 (184/238) Installing llvm18-libs (18.1.8-r5)
#8 11.98 (185/238) Installing clang18-libs (18.1.8-r5)
#8 12.61 (186/238) Installing fortify-headers (1.1-r5)
#8 12.62 (187/238) Installing llvm18-linker-tools (18.1.8-r5)
#8 12.63 (188/238) Installing clang18 (18.1.8-r5)
#8 12.65 (189/238) Installing llvm18 (18.1.8-r5)
#8 13.73 (190/238) Installing lz4-libs (1.10.0-r0)
#8 13.74 (191/238) Installing lz4-dev (1.10.0-r0)
#8 13.75 (192/238) Installing postgresql17-dev (17.5-r0)
#8 13.94 (193/238) Installing libdeflate-static (1.23-r0)
#8 13.95 (194/238) Installing openexr-libiex (3.3.2-r0)
#8 13.96 (195/238) Installing openexr-libilmthread (3.3.2-r0)
#8 13.97 (196/238) Installing imath (3.1.12-r0)
#8 13.98 (197/238) Installing libdeflate (1.23-r0)
#8 13.99 (198/238) Installing openexr-libopenexrcore (3.3.2-r0)
#8 14.00 (199/238) Installing openexr-libopenexr (3.3.2-r0)
#8 14.02 (200/238) Installing openexr-libopenexrutil (3.3.2-r0)
#8 14.03 (201/238) Installing boost1.84-python3 (1.84.0-r3)
#8 14.04 (202/238) Installing py3-imath (3.1.12-r0)
#8 14.16 (203/238) Installing imath-dev (3.1.12-r0)
#8 14.18 (204/238) Installing libdeflate-dev (1.23-r0)
#8 14.20 (205/238) Installing openexr-dev (3.3.2-r0)
#8 14.23 (206/238) Installing cfitsio (4.5.0-r0)
#8 14.25 (207/238) Installing cfitsio-dev (4.5.0-r0)
#8 14.26 (208/238) Installing cgif (0.5.0-r1)
#8 14.27 (209/238) Installing cgif-dev (0.5.0-r1)
#8 14.28 (210/238) Installing fftw-double-libs (3.3.10-r6)
#8 14.31 (211/238) Installing fftw-long-double-libs (3.3.10-r6)
#8 14.32 (212/238) Installing fftw-single-libs (3.3.10-r6)
#8 14.35 (213/238) Installing fftw-dev (3.3.10-r6)
#8 14.42 (214/238) Installing libimagequant (4.2.2-r0)
#8 14.44 (215/238) Installing libimagequant-dev (4.2.2-r0)
#8 14.44 (216/238) Installing lcms2 (2.16-r0)
#8 14.46 (217/238) Installing lcms2-plugins (2.16-r0)
#8 14.47 (218/238) Installing lcms2-dev (2.16-r0)
#8 14.48 (219/238) Installing acl-libs (2.3.2-r1)
#8 14.48 (220/238) Installing libarchive (3.8.1-r0)
#8 14.50 (221/238) Installing libarchive-dev (3.8.1-r0)
#8 14.51 (222/238) Installing libexif (0.6.25-r0)
#8 14.52 (223/238) Installing libexif-dev (0.6.25-r0)
#8 14.53 (224/238) Installing libhwy (1.0.7-r1)
#8 14.54 (225/238) Installing libhwy_contrib (1.0.7-r1)
#8 14.57 (226/238) Installing libhwy_test (1.0.7-r1)
#8 14.58 (227/238) Installing gtest (1.16.0-r0)
#8 14.60 (228/238) Installing gmock (1.16.0-r0)
#8 14.61 (229/238) Installing gtest-dev (1.16.0-r0)
#8 14.64 (230/238) Installing highway-dev (1.0.7-r1)
#8 14.67 (231/238) Installing openjpeg (2.5.3-r0)
#8 14.68 (232/238) Installing openjpeg-tools (2.5.3-r0)
#8 14.69 (233/238) Installing openjpeg-dev (2.5.3-r0)
#8 14.70 (234/238) Installing libspng (0.7.4-r1)
#8 14.71 (235/238) Installing libspng-dev (0.7.4-r1)
#8 14.73 (236/238) Installing vips (8.16.1-r0)
#8 14.76 (237/238) Installing vips-cpp (8.16.1-r0)
#8 14.77 (238/238) Installing vips-dev (8.16.1-r0)
#8 14.80 Executing busybox-1.37.0-r18.trigger
#8 14.81 Executing glib-2.84.3-r0.trigger
#8 14.81 No schema files found: doing nothing.
#8 14.82 Executing shared-mime-info-2.4-r6.trigger
#8 15.48 Executing gdk-pixbuf-2.42.12-r1.trigger
#8 15.52 OK: 862 MiB in 256 packages
#8 ...
#5 [internal] load build context
#5 DONE 20.7s
#8 [base  2/11] RUN npm install -g pnpm@9.15.5 &&     apk add --no-cache     curl     python3     make     g++     libc6-compat     vips-dev     cairo-dev     pango-dev     jpeg-dev     giflib-dev     librsvg-dev     pixman-dev     pangomm-dev     libjpeg-turbo-dev     freetype-dev     sqlite-dev     postgresql-dev
#8 DONE 18.8s
#12 [base  3/11] WORKDIR /app
#12 DONE 0.1s
#13 [base  4/11] COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
#13 DONE 0.0s
#14 [base  5/11] COPY turbo.json ./
#14 DONE 0.0s
#15 [base  6/11] COPY apps/ ./apps/
#15 DONE 4.8s
#16 [base  7/11] COPY packages/ ./packages/
#16 DONE 0.2s
#17 [base  8/11] RUN pnpm install --frozen-lockfile ||     (echo "❌ Frozen lockfile failed, trying without..." && pnpm install) ||     (echo "❌ Regular install failed, trying with --force..." && pnpm install --force)
#17 0.669 Scope: all 20 workspace projects
#17 0.902 Lockfile is up to date, resolution step is skipped
#17 1.151 Progress: resolved 1, reused 0, downloaded 0, added 0
#17 1.567 Packages: +3500
#17 1.567 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#17 2.127 
#17 2.127    ╭───────────────────────────────────────────────────────────────────╮
#17 2.127    │                                                                   │
#17 2.127    │                Update available! 9.15.5 → 10.13.1.                │
#17 2.127    │   Changelog: https://github.com/pnpm/pnpm/releases/tag/v10.13.1   │
#17 2.127    │                 Run "pnpm add -g pnpm" to update.                 │
#17 2.127    │                                                                   │
#17 2.127    ╰───────────────────────────────────────────────────────────────────╯
#17 2.127 
#17 2.154 Progress: resolved 3500, reused 0, downloaded 6, added 0
#17 3.155 Progress: resolved 3500, reused 0, downloaded 182, added 171
#17 4.157 Progress: resolved 3500, reused 0, downloaded 264, added 256
#17 5.157 Progress: resolved 3500, reused 0, downloaded 303, added 298
#17 6.159 Progress: resolved 3500, reused 0, downloaded 370, added 366
#17 7.169 Progress: resolved 3500, reused 0, downloaded 442, added 435
#17 8.171 Progress: resolved 3500, reused 0, downloaded 465, added 461
#17 9.171 Progress: resolved 3500, reused 0, downloaded 496, added 495
#17 10.17 Progress: resolved 3500, reused 0, downloaded 630, added 629
#17 11.17 Progress: resolved 3500, reused 0, downloaded 784, added 777
#17 12.18 Progress: resolved 3500, reused 0, downloaded 939, added 937
#17 13.18 Progress: resolved 3500, reused 0, downloaded 1160, added 1165
#17 14.18 Progress: resolved 3500, reused 0, downloaded 1308, added 1323
#17 15.18 Progress: resolved 3500, reused 0, downloaded 1517, added 1533
#17 16.18 Progress: resolved 3500, reused 0, downloaded 1722, added 1778
#17 17.18 Progress: resolved 3500, reused 0, downloaded 1829, added 1881
#17 18.18 Progress: resolved 3500, reused 0, downloaded 1936, added 1993
#17 19.18 Progress: resolved 3500, reused 0, downloaded 2069, added 2124
#17 20.18 Progress: resolved 3500, reused 0, downloaded 2189, added 2242
#17 21.21 Progress: resolved 3500, reused 0, downloaded 2346, added 2409
#17 22.21 Progress: resolved 3500, reused 0, downloaded 2545, added 2595
#17 23.21 Progress: resolved 3500, reused 0, downloaded 2751, added 2805
#17 24.21 Progress: resolved 3500, reused 0, downloaded 2881, added 2939
#17 25.21 Progress: resolved 3500, reused 0, downloaded 3021, added 3078
#17 26.21 Progress: resolved 3500, reused 0, downloaded 3136, added 3194
#17 27.21 Progress: resolved 3500, reused 0, downloaded 3271, added 3331
#17 28.21 Progress: resolved 3500, reused 0, downloaded 3401, added 3462
#17 29.21 Progress: resolved 3500, reused 0, downloaded 3431, added 3499
#17 29.74 Progress: resolved 3500, reused 0, downloaded 3432, added 3500, done
#17 31.11 .../node_modules/protobufjs postinstall$ node scripts/postinstall
#17 31.11  WARN  Failed to create bin at /app/node_modules/.pnpm/supabase@1.151.1_supports-color@8.1.1/node_modules/supabase/node_modules/.bin/supabase. ENOENT: no such file or directory, open '/app/node_modules/.pnpm/supabase@1.151.1_supports-color@8.1.1/node_modules/supabase/bin/supabase'
#17 31.12 .../node_modules/supabase postinstall$ node scripts/postinstall.js
#17 31.13 .../sharp@0.34.1/node_modules/sharp install$ node install/check
#17 31.13 .../sharp@0.32.6/node_modules/sharp install$ (node install/libvips && node install/dll-copy && prebuild-install) || (node install/can-compile && node-gyp rebuild && node install/dll-copy)
#17 31.15 .../esbuild@0.25.2/node_modules/esbuild postinstall$ node install.js
#17 31.17 .../node_modules/protobufjs postinstall: Done
#17 31.22 .../node_modules/@parcel/watcher install$ node scripts/build-from-source.js
#17 31.25 .../esbuild@0.25.2/node_modules/esbuild postinstall: Done
#17 31.27 .../sharp@0.34.1/node_modules/sharp install: sharp: Detected globally-installed libvips v8.16.1
#17 31.27 .../sharp@0.34.1/node_modules/sharp install: sharp: Attempting to build from source via node-gyp
#17 31.27 .../sharp@0.34.1/node_modules/sharp install: sharp: Found node-addon-api 
#17 31.28 .../sharp@0.34.1/node_modules/sharp install: sharp: Found node-gyp 10.1.0
#17 31.28 .../sharp@0.34.1/node_modules/sharp install: sharp: See https://sharp.pixelplumbing.com/install#building-from-source
#17 31.32 .../sharp@0.32.6/node_modules/sharp install: sharp: Detected globally-installed libvips v8.16.1
#17 31.32 .../sharp@0.32.6/node_modules/sharp install: sharp: Building from source via node-gyp
#17 31.32 .../node_modules/@parcel/watcher install: Done
#17 31.33 .../node-pty@1.0.0/node_modules/node-pty install$ node-gyp rebuild
#17 31.35 .../node_modules/msw postinstall$ node -e "try{require('./config/scripts/postinstall')}catch(e){}"
#17 31.39 .../sharp@0.34.1/node_modules/sharp install: gyp info it worked if it ends with ok
#17 31.39 .../sharp@0.34.1/node_modules/sharp install: gyp info using node-gyp@10.2.0
#17 31.39 .../sharp@0.34.1/node_modules/sharp install: gyp info using node@22.17.1 | linux | x64
#17 31.39 .../sharp@0.34.1/node_modules/sharp install: gyp info chdir src
#17 31.44 .../node-pty@1.0.0/node_modules/node-pty install: gyp info it worked if it ends with ok
#17 31.44 .../node_modules/msw postinstall: Done
#17 31.44 .../node-pty@1.0.0/node_modules/node-pty install: gyp info using node-gyp@10.2.0
#17 31.44 .../node-pty@1.0.0/node_modules/node-pty install: gyp info using node@22.17.1 | linux | x64
#17 31.45 .../node_modules/supabase postinstall: Downloading https://github.com/supabase/cli/releases/download/v1.151.1/supabase_linux_amd64.tar.gz
#17 31.52 .../sharp@0.32.6/node_modules/sharp install: gyp info it worked if it ends with ok
#17 31.52 .../sharp@0.32.6/node_modules/sharp install: gyp info using node-gyp@10.2.0
#17 31.52 .../sharp@0.32.6/node_modules/sharp install: gyp info using node@22.17.1 | linux | x64
#17 31.55 .../node-pty@1.0.0/node_modules/node-pty install: gyp info find Python using Python version 3.12.11 found at "/usr/bin/python3"
#17 31.56 .../sharp@0.34.1/node_modules/sharp install: gyp info find Python using Python version 3.12.11 found at "/usr/bin/python3"
#17 31.64 .../node_modules/@sentry/cli postinstall$ node ./scripts/install.js
#17 31.67 .../sharp@0.32.6/node_modules/sharp install: gyp info find Python using Python version 3.12.11 found at "/usr/bin/python3"
#17 31.71 .../node_modules/supabase postinstall: Downloading https://github.com/supabase/cli/releases/download/v1.151.1/supabase_1.151.1_checksums.txt
#17 31.74 .../node-pty@1.0.0/node_modules/node-pty install: gyp http GET https://unofficial-builds.nodejs.org/download/release/v22.17.1/node-v22.17.1-headers.tar.gz
#17 31.77 .../sharp@0.34.1/node_modules/sharp install: gyp http GET https://unofficial-builds.nodejs.org/download/release/v22.17.1/node-v22.17.1-headers.tar.gz
#17 31.79 .../node_modules/@sentry/cli postinstall: Done
#17 31.81 .../node_modules/msw postinstall$ node -e "try{require('./config/scripts/postinstall')}catch(e){}"
#17 31.85 .../sharp@0.32.6/node_modules/sharp install: gyp http GET https://unofficial-builds.nodejs.org/download/release/v22.17.1/node-v22.17.1-headers.tar.gz
#17 31.86 .../node_modules/msw postinstall: Done
#17 31.93 .../node_modules/@sentry/cli postinstall$ node ./scripts/install.js
#17 31.94 .../sharp@0.34.1/node_modules/sharp install: gyp http 200 https://unofficial-builds.nodejs.org/download/release/v22.17.1/node-v22.17.1-headers.tar.gz
#17 31.98 .../sharp@0.32.6/node_modules/sharp install: gyp http 200 https://unofficial-builds.nodejs.org/download/release/v22.17.1/node-v22.17.1-headers.tar.gz
#17 32.09 .../node_modules/@sentry/cli postinstall: Done
#17 32.10 .../node-pty@1.0.0/node_modules/node-pty install: gyp http 200 https://unofficial-builds.nodejs.org/download/release/v22.17.1/node-v22.17.1-headers.tar.gz
#17 32.13 .../node_modules/contentlayer2 postinstall$ node ./bin/cli.cjs postinstall || echo 'No Contentlayer build found.'
#17 32.67 .../node_modules/supabase postinstall: Checksum verified.
#17 32.69 .../node_modules/supabase postinstall: Installed Supabase CLI successfully
#17 32.71 .../node_modules/supabase postinstall: Done
#17 32.89 .../core-js@3.35.0/node_modules/core-js postinstall$ node -e "try{require('./postinstall')}catch(e){}"
#17 32.98 .../core-js@3.35.0/node_modules/core-js postinstall: Thank you for using core-js ( https://github.com/zloirock/core-js ) for polyfilling JavaScript standard library!
#17 32.98 .../core-js@3.35.0/node_modules/core-js postinstall: The project needs your help! Please consider supporting core-js:
#17 32.98 .../core-js@3.35.0/node_modules/core-js postinstall: > https://opencollective.com/core-js 
#17 32.99 .../core-js@3.35.0/node_modules/core-js postinstall: > https://patreon.com/zloirock 
#17 32.99 .../core-js@3.35.0/node_modules/core-js postinstall: > https://boosty.to/zloirock 
#17 32.99 .../core-js@3.35.0/node_modules/core-js postinstall: > bitcoin: bc1qlea7544qtsmj2rayg0lthvza9fau63ux0fstcz 
#17 32.99 .../core-js@3.35.0/node_modules/core-js postinstall: I highly recommend reading this: https://github.com/zloirock/core-js/blob/master/docs/2023-02-14-so-whats-next.md 
#17 33.00 .../core-js@3.35.0/node_modules/core-js postinstall: Done
#17 35.01 .../sharp@0.34.1/node_modules/sharp install: gyp http GET https://unofficial-builds.nodejs.org/download/release/v22.17.1/SHASUMS256.txt
#17 35.03 .../sharp@0.34.1/node_modules/sharp install: gyp http 200 https://unofficial-builds.nodejs.org/download/release/v22.17.1/SHASUMS256.txt
#17 35.04 .../sharp@0.34.1/node_modules/sharp install: gyp info spawn /usr/bin/python3
#17 35.04 .../sharp@0.34.1/node_modules/sharp install: gyp info spawn args [
#17 35.04 .../sharp@0.34.1/node_modules/sharp install: gyp info spawn args '/usr/local/lib/node_modules/pnpm/dist/node_modules/node-gyp/gyp/gyp_main.py',
#17 35.04 .../sharp@0.34.1/node_modules/sharp install: gyp info spawn args 'binding.gyp',
#17 35.04 .../sharp@0.34.1/node_modules/sharp install: gyp info spawn args '-f',
#17 35.04 .../sharp@0.34.1/node_modules/sharp install: gyp info spawn args 'make',
#17 35.04 .../sharp@0.34.1/node_modules/sharp install: gyp info spawn args '-I',
#17 35.04 .../sharp@0.34.1/node_modules/sharp install: gyp info spawn args '/app/node_modules/.pnpm/sharp@0.34.1/node_modules/sharp/src/build/config.gypi',
#17 35.04 .../sharp@0.34.1/node_modules/sharp install: gyp info spawn args '-I',
#17 35.04 .../sharp@0.34.1/node_modules/sharp install: gyp info spawn args '/usr/local/lib/node_modules/pnpm/dist/node_modules/node-gyp/addon.gypi',
#17 35.04 .../sharp@0.34.1/node_modules/sharp install: gyp info spawn args '-I',
#17 35.04 .../sharp@0.34.1/node_modules/sharp install: gyp info spawn args '/root/.cache/node-gyp/22.17.1/include/node/common.gypi',
#17 35.04 .../sharp@0.34.1/node_modules/sharp install: gyp info spawn args '-Dlibrary=shared_library',
#17 35.04 .../sharp@0.34.1/node_modules/sharp install: gyp info spawn args '-Dvisibility=default',
#17 35.05 .../sharp@0.34.1/node_modules/sharp install: gyp info spawn args '-Dnode_root_dir=/root/.cache/node-gyp/22.17.1',
#17 35.05 .../sharp@0.34.1/node_modules/sharp install: gyp info spawn args '-Dnode_gyp_dir=/usr/local/lib/node_modules/pnpm/dist/node_modules/node-gyp',
#17 35.05 .../sharp@0.34.1/node_modules/sharp install: gyp info spawn args '-Dnode_lib_file=/root/.cache/node-gyp/22.17.1/<(target_arch)/node.lib',
#17 35.05 .../sharp@0.34.1/node_modules/sharp install: gyp info spawn args '-Dmodule_root_dir=/app/node_modules/.pnpm/sharp@0.34.1/node_modules/sharp/src',
#17 35.05 .../sharp@0.34.1/node_modules/sharp install: gyp info spawn args '-Dnode_engine=v8',
#17 35.05 .../sharp@0.34.1/node_modules/sharp install: gyp info spawn args '--depth=.',
#17 35.05 .../sharp@0.34.1/node_modules/sharp install: gyp info spawn args '--no-parallel',
#17 35.05 .../sharp@0.34.1/node_modules/sharp install: gyp info spawn args '--generator-output',
#17 35.05 .../sharp@0.34.1/node_modules/sharp install: gyp info spawn args 'build',
#17 35.05 .../sharp@0.34.1/node_modules/sharp install: gyp info spawn args '-Goutput_dir=.'
#17 35.05 .../sharp@0.34.1/node_modules/sharp install: gyp info spawn args ]
#17 35.47 .../sharp@0.34.1/node_modules/sharp install: <string>:123: SyntaxWarning: invalid escape sequence '\/'
#17 35.86 .../node_modules/contentlayer2 postinstall: Done
#17 36.09 .../sharp@0.32.6/node_modules/sharp install: gyp http GET https://unofficial-builds.nodejs.org/download/release/v22.17.1/SHASUMS256.txt
#17 36.12 .../sharp@0.32.6/node_modules/sharp install: gyp http 200 https://unofficial-builds.nodejs.org/download/release/v22.17.1/SHASUMS256.txt
#17 36.12 .../node-pty@1.0.0/node_modules/node-pty install: gyp http GET https://unofficial-builds.nodejs.org/download/release/v22.17.1/SHASUMS256.txt
#17 36.13 .../sharp@0.32.6/node_modules/sharp install: gyp info spawn /usr/bin/python3
#17 36.13 .../sharp@0.32.6/node_modules/sharp install: gyp info spawn args [
#17 36.13 .../sharp@0.32.6/node_modules/sharp install: gyp info spawn args '/usr/local/lib/node_modules/pnpm/dist/node_modules/node-gyp/gyp/gyp_main.py',
#17 36.13 .../sharp@0.32.6/node_modules/sharp install: gyp info spawn args 'binding.gyp',
#17 36.13 .../sharp@0.32.6/node_modules/sharp install: gyp info spawn args '-f',
#17 36.13 .../sharp@0.32.6/node_modules/sharp install: gyp info spawn args 'make',
#17 36.13 .../sharp@0.32.6/node_modules/sharp install: gyp info spawn args '-I',
#17 36.13 .../sharp@0.32.6/node_modules/sharp install: gyp info spawn args '/app/node_modules/.pnpm/sharp@0.32.6/node_modules/sharp/build/config.gypi',
#17 36.13 .../sharp@0.32.6/node_modules/sharp install: gyp info spawn args '-I',
#17 36.13 .../sharp@0.32.6/node_modules/sharp install: gyp info spawn args '/usr/local/lib/node_modules/pnpm/dist/node_modules/node-gyp/addon.gypi',
#17 36.13 .../sharp@0.32.6/node_modules/sharp install: gyp info spawn args '-I',
#17 36.13 .../sharp@0.32.6/node_modules/sharp install: gyp info spawn args '/root/.cache/node-gyp/22.17.1/include/node/common.gypi',
#17 36.13 .../sharp@0.32.6/node_modules/sharp install: gyp info spawn args '-Dlibrary=shared_library',
#17 36.13 .../sharp@0.32.6/node_modules/sharp install: gyp info spawn args '-Dvisibility=default',
#17 36.13 .../sharp@0.32.6/node_modules/sharp install: gyp info spawn args '-Dnode_root_dir=/root/.cache/node-gyp/22.17.1',
#17 36.13 .../sharp@0.32.6/node_modules/sharp install: gyp info spawn args '-Dnode_gyp_dir=/usr/local/lib/node_modules/pnpm/dist/node_modules/node-gyp',
#17 36.13 .../sharp@0.32.6/node_modules/sharp install: gyp info spawn args '-Dnode_lib_file=/root/.cache/node-gyp/22.17.1/<(target_arch)/node.lib',
#17 36.13 .../sharp@0.32.6/node_modules/sharp install: gyp info spawn args '-Dmodule_root_dir=/app/node_modules/.pnpm/sharp@0.32.6/node_modules/sharp',
#17 36.13 .../sharp@0.32.6/node_modules/sharp install: gyp info spawn args '-Dnode_engine=v8',
#17 36.13 .../sharp@0.32.6/node_modules/sharp install: gyp info spawn args '--depth=.',
#17 36.13 .../sharp@0.32.6/node_modules/sharp install: gyp info spawn args '--no-parallel',
#17 36.13 .../sharp@0.32.6/node_modules/sharp install: gyp info spawn args '--generator-output',
#17 36.13 .../sharp@0.32.6/node_modules/sharp install: gyp info spawn args 'build',
#17 36.13 .../sharp@0.32.6/node_modules/sharp install: gyp info spawn args '-Goutput_dir=.'
#17 36.13 .../sharp@0.32.6/node_modules/sharp install: gyp info spawn args ]
#17 36.14 .../node-pty@1.0.0/node_modules/node-pty install: gyp http 200 https://unofficial-builds.nodejs.org/download/release/v22.17.1/SHASUMS256.txt
#17 36.15 .../node-pty@1.0.0/node_modules/node-pty install: gyp info spawn /usr/bin/python3
#17 36.15 .../node-pty@1.0.0/node_modules/node-pty install: gyp info spawn args [
#17 36.15 .../node-pty@1.0.0/node_modules/node-pty install: gyp info spawn args '/usr/local/lib/node_modules/pnpm/dist/node_modules/node-gyp/gyp/gyp_main.py',
#17 36.15 .../node-pty@1.0.0/node_modules/node-pty install: gyp info spawn args 'binding.gyp',
#17 36.15 .../node-pty@1.0.0/node_modules/node-pty install: gyp info spawn args '-f',
#17 36.15 .../node-pty@1.0.0/node_modules/node-pty install: gyp info spawn args 'make',
#17 36.15 .../node-pty@1.0.0/node_modules/node-pty install: gyp info spawn args '-I',
#17 36.15 .../node-pty@1.0.0/node_modules/node-pty install: gyp info spawn args '/app/node_modules/.pnpm/node-pty@1.0.0/node_modules/node-pty/build/config.gypi',
#17 36.15 .../node-pty@1.0.0/node_modules/node-pty install: gyp info spawn args '-I',
#17 36.15 .../node-pty@1.0.0/node_modules/node-pty install: gyp info spawn args '/usr/local/lib/node_modules/pnpm/dist/node_modules/node-gyp/addon.gypi',
#17 36.15 .../node-pty@1.0.0/node_modules/node-pty install: gyp info spawn args '-I',
#17 36.15 .../node-pty@1.0.0/node_modules/node-pty install: gyp info spawn args '/root/.cache/node-gyp/22.17.1/include/node/common.gypi',
#17 36.15 .../node-pty@1.0.0/node_modules/node-pty install: gyp info spawn args '-Dlibrary=shared_library',
#17 36.15 .../node-pty@1.0.0/node_modules/node-pty install: gyp info spawn args '-Dvisibility=default',
#17 36.15 .../node-pty@1.0.0/node_modules/node-pty install: gyp info spawn args '-Dnode_root_dir=/root/.cache/node-gyp/22.17.1',
#17 36.15 .../node-pty@1.0.0/node_modules/node-pty install: gyp info spawn args '-Dnode_gyp_dir=/usr/local/lib/node_modules/pnpm/dist/node_modules/node-gyp',
#17 36.15 .../node-pty@1.0.0/node_modules/node-pty install: gyp info spawn args '-Dnode_lib_file=/root/.cache/node-gyp/22.17.1/<(target_arch)/node.lib',
#17 36.15 .../node-pty@1.0.0/node_modules/node-pty install: gyp info spawn args '-Dmodule_root_dir=/app/node_modules/.pnpm/node-pty@1.0.0/node_modules/node-pty',
#17 36.15 .../node-pty@1.0.0/node_modules/node-pty install: gyp info spawn args '-Dnode_engine=v8',
#17 36.15 .../node-pty@1.0.0/node_modules/node-pty install: gyp info spawn args '--depth=.',
#17 36.15 .../node-pty@1.0.0/node_modules/node-pty install: gyp info spawn args '--no-parallel',
#17 36.15 .../node-pty@1.0.0/node_modules/node-pty install: gyp info spawn args '--generator-output',
#17 36.16 .../node-pty@1.0.0/node_modules/node-pty install: gyp info spawn args 'build',
#17 36.16 .../node-pty@1.0.0/node_modules/node-pty install: gyp info spawn args '-Goutput_dir=.'
#17 36.16 .../node-pty@1.0.0/node_modules/node-pty install: gyp info spawn args ]
#17 36.22 .../sharp@0.32.6/node_modules/sharp install: <string>:108: SyntaxWarning: invalid escape sequence '\/'
#17 36.34 .../node-pty@1.0.0/node_modules/node-pty install: gyp info spawn make
#17 36.34 .../node-pty@1.0.0/node_modules/node-pty install: gyp info spawn args [ 'BUILDTYPE=Release', '-C', 'build' ]
#17 36.34 .../node-pty@1.0.0/node_modules/node-pty install: make: Entering directory '/app/node_modules/.pnpm/node-pty@1.0.0/node_modules/node-pty/build'
#17 36.34 .../node-pty@1.0.0/node_modules/node-pty install:   CXX(target) Release/obj.target/pty/src/unix/pty.o
#17 36.45 .../sharp@0.34.1/node_modules/sharp install: gyp info spawn make
#17 36.45 .../sharp@0.34.1/node_modules/sharp install: gyp info spawn args [ 'BUILDTYPE=Release', '-C', 'build' ]
#17 36.46 .../sharp@0.34.1/node_modules/sharp install: make: Entering directory '/app/node_modules/.pnpm/sharp@0.34.1/node_modules/sharp/src/build'
#17 36.46 .../sharp@0.34.1/node_modules/sharp install:   CC(target) Release/obj.target/nothing/../../../../node-addon-api@7.1.0/node_modules/node-addon-api/nothing.o
#17 36.48 .../sharp@0.34.1/node_modules/sharp install: rm -f Release/obj.target/../../../../node-addon-api@7.1.0/node_modules/node-addon-api/nothing.a Release/obj.target/../../../../node-addon-api@7.1.0/node_modules/node-addon-api/nothing.a.ar-file-list; mkdir -p `dirname Release/obj.target/../../../../node-addon-api@7.1.0/node_modules/node-addon-api/nothing.a`
#17 36.49 .../sharp@0.34.1/node_modules/sharp install: ar crs Release/obj.target/../../../../node-addon-api@7.1.0/node_modules/node-addon-api/nothing.a @Release/obj.target/../../../../node-addon-api@7.1.0/node_modules/node-addon-api/nothing.a.ar-file-list
#17 36.49 .../sharp@0.34.1/node_modules/sharp install:   COPY Release/nothing.a
#17 36.50 .../sharp@0.34.1/node_modules/sharp install:   TOUCH Release/obj.target/libvips-cpp-8.16.1.stamp
#17 36.50 .../sharp@0.34.1/node_modules/sharp install:   CXX(target) Release/obj.target/sharp-linuxmusl-x64/common.o
#17 36.73 .../sharp@0.32.6/node_modules/sharp install: gyp info spawn make
#17 36.74 .../sharp@0.32.6/node_modules/sharp install: gyp info spawn args [ 'BUILDTYPE=Release', '-C', 'build' ]
#17 36.74 .../sharp@0.32.6/node_modules/sharp install: make: Entering directory '/app/node_modules/.pnpm/sharp@0.32.6/node_modules/sharp/build'
#17 36.74 .../sharp@0.32.6/node_modules/sharp install:   CC(target) Release/obj.target/nothing/../../../node-addon-api@6.1.0/node_modules/node-addon-api/nothing.o
#17 36.78 .../sharp@0.32.6/node_modules/sharp install: rm -f Release/obj.target/../../../node-addon-api@6.1.0/node_modules/node-addon-api/nothing.a Release/obj.target/../../../node-addon-api@6.1.0/node_modules/node-addon-api/nothing.a.ar-file-list; mkdir -p `dirname Release/obj.target/../../../node-addon-api@6.1.0/node_modules/node-addon-api/nothing.a`
#17 36.78 .../sharp@0.32.6/node_modules/sharp install: ar crs Release/obj.target/../../../node-addon-api@6.1.0/node_modules/node-addon-api/nothing.a @Release/obj.target/../../../node-addon-api@6.1.0/node_modules/node-addon-api/nothing.a.ar-file-list
#17 36.79 .../sharp@0.32.6/node_modules/sharp install:   COPY Release/nothing.a
#17 36.79 .../sharp@0.32.6/node_modules/sharp install:   TOUCH Release/obj.target/libvips-cpp.stamp
#17 36.80 .../sharp@0.32.6/node_modules/sharp install:   CXX(target) Release/obj.target/sharp-linuxmusl-x64/src/common.o
#17 37.67 .../node-pty@1.0.0/node_modules/node-pty install: ../src/unix/pty.cc: In function 'void pty_after_waitpid(uv_async_t*)':
#17 37.67 .../node-pty@1.0.0/node_modules/node-pty install: ../src/unix/pty.cc:609:9: warning: 'void* memset(void*, int, size_t)' writing to an object of type 'class Nan::Persistent<v8::Function>' with no trivial copy-assignment [-Wclass-memaccess]
#17 37.67 .../node-pty@1.0.0/node_modules/node-pty install:   609 |   memset(&baton->cb, -1, sizeof(baton->cb));
#17 37.67 .../node-pty@1.0.0/node_modules/node-pty install:       |   ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#17 37.67 .../node-pty@1.0.0/node_modules/node-pty install: In file included from ../../../../nan@2.22.1/node_modules/nan/nan.h:423,
#17 37.67 .../node-pty@1.0.0/node_modules/node-pty install:                  from ../src/unix/pty.cc:20:
#17 37.67 .../node-pty@1.0.0/node_modules/node-pty install: ../../../../nan@2.22.1/node_modules/nan/nan_persistent_12_inl.h:12:40: note: 'class Nan::Persistent<v8::Function>' declared here
#17 37.67 .../node-pty@1.0.0/node_modules/node-pty install:    12 | template<typename T, typename M> class Persistent :
#17 37.67 .../node-pty@1.0.0/node_modules/node-pty install:       |                                        ^~~~~~~~~~
#17 37.67 .../node-pty@1.0.0/node_modules/node-pty install: In file included from ../../../../nan@2.22.1/node_modules/nan/nan.h:62:
#17 37.67 .../node-pty@1.0.0/node_modules/node-pty install: ../src/unix/pty.cc: At global scope:
#17 37.67 .../node-pty@1.0.0/node_modules/node-pty install: /root/.cache/node-gyp/22.17.1/include/node/node.h:1228:7: warning: cast between incompatible function types from 'void (*)(Nan::ADDON_REGISTER_FUNCTION_ARGS_TYPE)' {aka 'void (*)(v8::Local<v8::Object>)'} to 'node::addon_register_func' {aka 'void (*)(v8::Local<v8::Object>, v8::Local<v8::Value>, void*)'} [-Wcast-function-type]
#17 37.68 .../node-pty@1.0.0/node_modules/node-pty install:  1228 |       (node::addon_register_func) (regfunc),                          \
#17 37.68 .../node-pty@1.0.0/node_modules/node-pty install:       |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#17 37.68 .../node-pty@1.0.0/node_modules/node-pty install: /root/.cache/node-gyp/22.17.1/include/node/node.h:1262:3: note: in expansion of macro 'NODE_MODULE_X'
#17 37.68 .../node-pty@1.0.0/node_modules/node-pty install:  1262 |   NODE_MODULE_X(modname, regfunc, NULL, 0)  // NOLINT (readability/null_usage)
#17 37.68 .../node-pty@1.0.0/node_modules/node-pty install:       |   ^~~~~~~~~~~~~
#17 37.68 .../node-pty@1.0.0/node_modules/node-pty install: ../src/unix/pty.cc:826:1: note: in expansion of macro 'NODE_MODULE'
#17 37.68 .../node-pty@1.0.0/node_modules/node-pty install:   826 | NODE_MODULE(pty, init)
#17 37.68 .../node-pty@1.0.0/node_modules/node-pty install:       | ^~~~~~~~~~~
#17 38.66 .../node-pty@1.0.0/node_modules/node-pty install:   SOLINK_MODULE(target) Release/obj.target/pty.node
#17 38.70 .../node-pty@1.0.0/node_modules/node-pty install:   COPY Release/pty.node
#17 38.70 .../node-pty@1.0.0/node_modules/node-pty install: make: Leaving directory '/app/node_modules/.pnpm/node-pty@1.0.0/node_modules/node-pty/build'
#17 38.71 .../node-pty@1.0.0/node_modules/node-pty install: gyp info ok 
#17 38.73 .../node-pty@1.0.0/node_modules/node-pty install: Done
#17 38.73 .../node-pty@1.0.0/node_modules/node-pty postinstall$ node scripts/post-install.js
#17 38.79 .../node-pty@1.0.0/node_modules/node-pty postinstall: Done
#17 39.51 .../sharp@0.32.6/node_modules/sharp install:   CXX(target) Release/obj.target/sharp-linuxmusl-x64/src/metadata.o
#17 40.47 .../sharp@0.34.1/node_modules/sharp install:   CXX(target) Release/obj.target/sharp-linuxmusl-x64/metadata.o
#17 41.38 .../sharp@0.32.6/node_modules/sharp install:   CXX(target) Release/obj.target/sharp-linuxmusl-x64/src/stats.o
#17 42.69 .../sharp@0.34.1/node_modules/sharp install:   CXX(target) Release/obj.target/sharp-linuxmusl-x64/stats.o
#17 42.95 .../sharp@0.32.6/node_modules/sharp install:   CXX(target) Release/obj.target/sharp-linuxmusl-x64/src/operations.o
#17 44.49 .../sharp@0.34.1/node_modules/sharp install:   CXX(target) Release/obj.target/sharp-linuxmusl-x64/operations.o
#17 44.69 .../sharp@0.32.6/node_modules/sharp install:   CXX(target) Release/obj.target/sharp-linuxmusl-x64/src/pipeline.o
#17 46.48 .../sharp@0.34.1/node_modules/sharp install:   CXX(target) Release/obj.target/sharp-linuxmusl-x64/pipeline.o
#17 48.97 .../sharp@0.32.6/node_modules/sharp install:   CXX(target) Release/obj.target/sharp-linuxmusl-x64/src/utilities.o
#17 50.53 .../sharp@0.32.6/node_modules/sharp install:   CXX(target) Release/obj.target/sharp-linuxmusl-x64/src/sharp.o
#17 51.33 .../sharp@0.34.1/node_modules/sharp install:   CXX(target) Release/obj.target/sharp-linuxmusl-x64/utilities.o
#17 51.91 .../sharp@0.32.6/node_modules/sharp install:   SOLINK_MODULE(target) Release/obj.target/sharp-linuxmusl-x64.node
#17 51.96 .../sharp@0.32.6/node_modules/sharp install:   COPY Release/sharp-linuxmusl-x64.node
#17 51.97 .../sharp@0.32.6/node_modules/sharp install: make: Leaving directory '/app/node_modules/.pnpm/sharp@0.32.6/node_modules/sharp/build'
#17 51.97 .../sharp@0.32.6/node_modules/sharp install: gyp info ok 
#17 52.03 .../sharp@0.32.6/node_modules/sharp install: Done
#17 53.12 .../sharp@0.34.1/node_modules/sharp install:   CXX(target) Release/obj.target/sharp-linuxmusl-x64/sharp.o
#17 54.66 .../sharp@0.34.1/node_modules/sharp install:   SOLINK_MODULE(target) Release/obj.target/sharp-linuxmusl-x64.node
#17 54.71 .../sharp@0.34.1/node_modules/sharp install:   COPY Release/sharp-linuxmusl-x64.node
#17 54.72 .../sharp@0.34.1/node_modules/sharp install:   TOUCH Release/obj.target/copy-dll.stamp
#17 54.72 .../sharp@0.34.1/node_modules/sharp install: make: Leaving directory '/app/node_modules/.pnpm/sharp@0.34.1/node_modules/sharp/src/build'
#17 54.72 .../sharp@0.34.1/node_modules/sharp install: gyp info ok 
#17 54.74 .../sharp@0.34.1/node_modules/sharp install: Done
#17 54.76 .../node_modules/contentlayer2 postinstall$ node ./bin/cli.cjs postinstall || echo 'No Contentlayer build found.'
#17 56.43 .../node_modules/contentlayer2 postinstall: Done
#17 56.45 .../es5-ext@0.10.64/node_modules/es5-ext postinstall$  node -e "try{require('./_postinstall')}catch(e){}" || exit 0
#17 56.50 .../es5-ext@0.10.64/node_modules/es5-ext postinstall: Done
#17 57.33 
#17 57.33 devDependencies:
#17 57.33 + @aws-sdk/client-secrets-manager 3.468.0
#17 57.33 + @types/node 22.13.14
#17 57.33 + eslint 8.57.0
#17 57.33 + prettier 3.2.4
#17 57.33 + prettier-plugin-sql-cst 0.11.1
#17 57.33 + rimraf 6.0.1
#17 57.33 + sass 1.72.0
#17 57.33 + supabase 1.151.1
#17 57.33 + supports-color 8.1.1
#17 57.33 + turbo 2.3.3
#17 57.33 + typescript 5.5.2
#17 57.33 
#17 57.33 The following dependencies have build scripts that were ignored: libpg-query
#17 57.33 To allow the execution of build scripts for these packages, add their names to "pnpm.onlyBuiltDependencies" in your "package.json", then run "pnpm rebuild"
#17 57.33 
#17 57.78 Done in 57.7s
#17 DONE 58.7s
#18 [base  9/11] COPY . .
#18 DONE 11.5s
#19 [base 10/11] RUN chmod +x scripts/*.sh
#19 DONE 0.2s
#20 [base 11/11] RUN pnpm build:studio
#20 1.297 
#20 1.297 > ultrabase@1.0.0 build:studio /app
#20 1.297 > turbo run build --filter=studio
#20 1.297 
#20 1.362 
#20 1.362 Attention:
#20 1.362 Turborepo now collects completely anonymous telemetry regarding usage.
#20 1.362 This information is used to shape the Turborepo roadmap and prioritize features.
#20 1.362 You can learn more, including how to opt-out if you'd not like to participate in this anonymous program, by visiting the following URL:
#20 1.362 https://turbo.build/repo/docs/telemetry
#20 1.362 
#20 1.363 turbo 2.3.3
#20 1.363 
#20 1.518 • Packages in scope: studio
#20 1.518 • Running build in 1 packages
#20 1.518 • Remote caching disabled
#20 1.682 studio:build: cache miss, executing 8294045c2c2b73eb
#20 2.207 studio:build: 
#20 2.207 studio:build: > studio@0.0.9 build /app/apps/studio
#20 2.207 studio:build: > next build && ./../../scripts/upload-static-assets.sh
#20 2.207 studio:build: 
#20 3.522 studio:build:    ▲ Next.js 15.3.1
#20 3.522 studio:build:    - Environments: .env
#20 3.522 studio:build:    - Experiments (use with caution):
#20 3.522 studio:build:      ✓ webpackBuildWorker
#20 3.522 studio:build: 
#20 3.523 studio:build:    Skipping validation of types
#20 3.524 studio:build:    Skipping linting
#20 3.853 studio:build:    Creating an optimized production build ...
#20 67.11 studio:build:  ⚠ Compiled with warnings in 61s
#20 67.11 studio:build: 
#20 67.11 studio:build: ../../node_modules/.pnpm/@opentelemetry+instrumentation@0.56.0_@opentelemetry+api@1.9.0_supports-color@8.1.1/node_modules/@opentelemetry/instrumentation/build/esm/platform/node/instrumentation.js
#20 67.11 studio:build: Critical dependency: the request of a dependency is an expression
#20 67.11 studio:build: 
#20 67.11 studio:build: Import trace for requested module:
#20 67.11 studio:build: ../../node_modules/.pnpm/@opentelemetry+instrumentation@0.56.0_@opentelemetry+api@1.9.0_supports-color@8.1.1/node_modules/@opentelemetry/instrumentation/build/esm/platform/node/instrumentation.js
#20 67.11 studio:build: ../../node_modules/.pnpm/@opentelemetry+instrumentation@0.56.0_@opentelemetry+api@1.9.0_supports-color@8.1.1/node_modules/@opentelemetry/instrumentation/build/esm/platform/node/index.js
#20 67.11 studio:build: ../../node_modules/.pnpm/@opentelemetry+instrumentation@0.56.0_@opentelemetry+api@1.9.0_supports-color@8.1.1/node_modules/@opentelemetry/instrumentation/build/esm/platform/index.js
#20 67.11 studio:build: ../../node_modules/.pnpm/@opentelemetry+instrumentation@0.56.0_@opentelemetry+api@1.9.0_supports-color@8.1.1/node_modules/@opentelemetry/instrumentation/build/esm/index.js
#20 67.11 studio:build: ../../node_modules/.pnpm/@sentry+node@8.52.1_supports-color@8.1.1/node_modules/@sentry/node/build/cjs/integrations/node-fetch.js
#20 67.11 studio:build: ../../node_modules/.pnpm/@sentry+node@8.52.1_supports-color@8.1.1/node_modules/@sentry/node/build/cjs/index.js
#20 67.11 studio:build: ../../node_modules/.pnpm/@sentry+nextjs@8.52.1_@opentelemetry+core@1.30.1_@opentelemetry+api@1.9.0__@opentelemetry+ins_cos5q27i6p6yusxldu26h5bmoe/node_modules/@sentry/nextjs/build/cjs/index.server.js
#20 67.11 studio:build: 
#20 85.23 studio:build: 
#20 85.23 studio:build: warn - The class `duration-[120ms]` is ambiguous and matches multiple utilities.
#20 85.23 studio:build: warn - If this is content and not a class, replace it with `duration-&lsqb;120ms&rsqb;` to silence this warning.
#20 85.23 studio:build: 
#20 85.23 studio:build: warn - The class `duration-[2s]` is ambiguous and matches multiple utilities.
#20 85.23 studio:build: warn - If this is content and not a class, replace it with `duration-&lsqb;2s&rsqb;` to silence this warning.
#20 85.23 studio:build: 
#20 85.23 studio:build: warn - The class `ease-[.76,0,.23,1]` is ambiguous and matches multiple utilities.
#20 85.23 studio:build: warn - If this is content and not a class, replace it with `ease-&lsqb;.76,0,.23,1&rsqb;` to silence this warning.
#20 133.3 studio:build:  ✓ Compiled successfully in 2.0min
#20 133.3 studio:build:    Collecting page data ...
#20 148.4 studio:build:    Generating static pages (0/151) ...
#20 155.5 studio:build:    Generating static pages (37/151) 
#20 156.4 studio:build:    Generating static pages (75/151) 
#20 157.0 studio:build:    Generating static pages (113/151) 
#20 157.6 studio:build:  ✓ Generating static pages (151/151)
#20 263.3 studio:build:    Finalizing page optimization ...
#20 263.3 studio:build:    Collecting build traces ...
#20 275.7 studio:build: 
#20 275.7 studio:build: Route (pages)                                                            Size  First Load JS
#20 275.7 studio:build: ┌   /_app                                                                 0 B         422 kB
#20 275.7 studio:build: ├ ○ /404 (3935 ms)                                                      959 B         427 kB
#20 275.7 studio:build: ├ ○ /500 (3930 ms)                                                       1 kB         427 kB
#20 275.7 studio:build: ├ ○ /account/audit (4077 ms)                                            498 B         871 kB
#20 275.7 studio:build: ├ ○ /account/me (4078 ms)                                             12.4 kB         812 kB
#20 275.7 studio:build: ├ ○ /account/security (614 ms)                                        1.34 kB         872 kB
#20 275.7 studio:build: ├ ○ /account/tokens (614 ms)                                          1.27 kB         872 kB
#20 275.7 studio:build: ├ ƒ /api/ai/edge-function/complete                                        0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/ai/edge-function/complete-v2                                     0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/ai/feedback/classify                                             0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/ai/onboarding/design                                             0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/ai/sql/check-api-key                                             0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/ai/sql/complete                                                  0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/ai/sql/complete-v2                                               0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/ai/sql/cron                                                      0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/ai/sql/cron-v2                                                   0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/ai/sql/generate-v3                                               0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/ai/sql/generate-v4                                               0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/ai/sql/title                                                     0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/ai/sql/title-v2                                                  0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/ai/sql/tools                                                     0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/check-cname                                                      0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/cli-release-version                                              0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/connect                                                          0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/constants                                                        0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/edge-functions/body                                              0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/edge-functions/test                                              0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/get-ip-address                                                   0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/get-utc-time                                                     0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/health                                                           0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/auth/[ref]/config                                       0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/auth/[ref]/invite                                       0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/auth/[ref]/magiclink                                    0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/auth/[ref]/otp                                          0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/auth/[ref]/recover                                      0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/auth/[ref]/users                                        0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/auth/[ref]/users/[id]                                   0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/auth/[ref]/users/[id]/factors                           0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/database/[ref]/pooling                                  0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/integrations/[slug]                                     0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/integrations/github/authorization                       0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/integrations/github/connections                         0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/integrations/github/repositories                        0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/organizations                                           0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/organizations/[slug]/billing/subscription               0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/pg-meta/[ref]/column-privileges                         0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/pg-meta/[ref]/columns                                   0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/pg-meta/[ref]/extensions                                0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/pg-meta/[ref]/foreign-tables                            0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/pg-meta/[ref]/materialized-views                        0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/pg-meta/[ref]/policies                                  0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/pg-meta/[ref]/publications                              0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/pg-meta/[ref]/query                                     0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/pg-meta/[ref]/query/format                              0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/pg-meta/[ref]/query/validate                            0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/pg-meta/[ref]/tables                                    0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/pg-meta/[ref]/triggers                                  0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/pg-meta/[ref]/types                                     0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/pg-meta/[ref]/views                                     0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/profile                                                 0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/profile/password-check                                  0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/projects                                                0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/projects/[ref]                                          0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/projects/[ref]/analytics/endpoints/[name]               0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/projects/[ref]/api/graphql                              0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/projects/[ref]/api/rest                                 0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/projects/[ref]/billing/addons                           0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/projects/[ref]/config                                   0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/projects/[ref]/config/postgrest                         0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/projects/[ref]/content                                  0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/projects/[ref]/content/count                            0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/projects/[ref]/content/folders                          0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/projects/[ref]/content/folders/[id]                     0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/projects/[ref]/content/item/[id]                        0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/projects/[ref]/databases                                0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/projects/[ref]/infra-monitoring                         0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/projects/[ref]/run-lints                                0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/projects/[ref]/settings                                 0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/props/org/[slug]                                        0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/props/project/[ref]                                     0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/props/project/[ref]/api                                 0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/storage/[ref]/buckets                                   0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/storage/[ref]/buckets/[id]                              0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/storage/[ref]/buckets/[id]/empty                        0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/storage/[ref]/buckets/[id]/objects                      0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/storage/[ref]/buckets/[id]/objects/download             0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/storage/[ref]/buckets/[id]/objects/list                 0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/storage/[ref]/buckets/[id]/objects/move                 0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/storage/[ref]/buckets/[id]/objects/public-url           0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/storage/[ref]/buckets/[id]/objects/sign                 0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/platform/telemetry/event                                         0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/ultrabase/organizations                                          0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/ultrabase/projects                                               0 B         422 kB
#20 275.7 studio:build: ├ ƒ /api/v1/projects/[ref]/types/typescript                               0 B         422 kB
#20 275.7 studio:build: ├ ○ /authorize (3929 ms)                                              4.91 kB         446 kB
#20 275.7 studio:build: ├ ○ /claim-project (3929 ms)                                          9.89 kB         499 kB
#20 275.7 studio:build: ├ ○ /cli/login (3929 ms)                                              7.82 kB         434 kB
#20 275.7 studio:build: ├ ○ /forgot-password (311 ms)                                         4.79 kB         455 kB
#20 275.7 studio:build: ├ ○ /forgot-password-mfa (3929 ms)                                    6.81 kB         456 kB
#20 275.7 studio:build: ├ ○ /integrations/github/authorize (369 ms)                             895 B         423 kB
#20 275.7 studio:build: ├ ○ /integrations/vercel/[slug]/deploy-button/new-project (369 ms)    14.1 kB         466 kB
#20 275.7 studio:build: ├ ○ /integrations/vercel/[slug]/marketplace/choose-project (369 ms)   10.9 kB         454 kB
#20 275.7 studio:build: ├ ○ /integrations/vercel/install (369 ms)                             8.99 kB         452 kB
#20 275.7 studio:build: ├ ○ /join (359 ms)                                                       3 kB         425 kB
#20 275.7 studio:build: ├ ○ /logout (359 ms)                                                    885 B         423 kB
#20 275.7 studio:build: ├ ○ /new (793 ms)                                                     1.37 kB         1.1 MB
#20 275.7 studio:build: ├ ○ /new/[slug] (309 ms)                                              22.2 kB         819 kB
#20 275.7 studio:build: ├ ○ /org                                                              3.54 kB         790 kB
#20 275.7 studio:build: ├ ○ /org/_/[[...routeSlug]]                                           3.94 kB         426 kB
#20 275.7 studio:build: ├ ○ /org/[slug]                                                       3.61 kB         802 kB
#20 275.7 studio:build: ├ ○ /org/[slug]/apps (793 ms)                                         2.17 kB         1.1 MB
#20 275.7 studio:build: ├ ○ /org/[slug]/audit                                                 2.17 kB         1.1 MB
#20 275.7 studio:build: ├ ○ /org/[slug]/billing (613 ms)                                      39.4 kB         858 kB
#20 275.7 studio:build: ├ ○ /org/[slug]/documents (793 ms)                                    1.68 kB         1.1 MB
#20 275.7 studio:build: ├ ○ /org/[slug]/general (793 ms)                                      2.17 kB         1.1 MB
#20 275.7 studio:build: ├ ○ /org/[slug]/integrations (793 ms)                                 1.68 kB         1.1 MB
#20 275.7 studio:build: ├ ○ /org/[slug]/security                                              2.17 kB         1.1 MB
#20 275.7 studio:build: ├ ○ /org/[slug]/team                                                  21.3 kB         818 kB
#20 275.7 studio:build: ├ ○ /org/[slug]/usage                                                 2.17 kB         1.1 MB
#20 275.7 studio:build: ├ ○ /organizations                                                    4.88 kB         792 kB
#20 275.7 studio:build: ├ ○ /project/_/[[...routeSlug]]                                       11.3 kB         465 kB
#20 275.7 studio:build: ├ ○ /project/[ref] (450 ms)                                           23.9 kB        1.18 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/advisors/performance (1096 ms)                     1.16 kB        1.17 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/advisors/query-performance (1095 ms)               17.4 kB        1.18 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/advisors/rules/performance (1096 ms)                 444 B        1.17 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/advisors/rules/security (1096 ms)                    441 B        1.17 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/advisors/security                                  1.15 kB        1.17 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/api (1096 ms)                                      15.2 kB        1.17 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/auth (1095 ms)                                     2.77 kB        1.16 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/auth/advanced (1096 ms)                            1.01 kB        1.16 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/auth/hooks (1095 ms)                               15.6 kB        1.17 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/auth/mfa (429 ms)                                    703 B        1.22 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/auth/policies (426 ms)                             22.9 kB        1.21 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/auth/protection (5043 ms)                            708 B        1.22 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/auth/providers (428 ms)                              817 B        1.22 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/auth/rate-limits (425 ms)                          7.94 kB        1.16 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/auth/sessions (428 ms)                               706 B        1.22 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/auth/smtp (428 ms)                                   769 B        1.22 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/auth/templates (428 ms)                              779 B        1.22 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/auth/third-party (428 ms)                            822 B        1.22 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/auth/url-configuration                             10.6 kB        1.18 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/auth/users                                         24.1 kB        1.21 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/branches (5046 ms)                                 6.34 kB        1.17 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/branches/merge-requests (5042 ms)                  2.39 kB        1.17 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/building (5043 ms)                                   521 B        1.16 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/database (405 ms)                                  2.78 kB        1.16 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/database/backups/pitr (5042 ms)                     4.2 kB        1.17 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/database/backups/restore-to-new-project (5042 ms)  11.4 kB        1.18 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/database/backups/scheduled (5041 ms)               2.33 kB        1.25 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/database/column-privileges (485 ms)                22.7 kB        1.18 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/database/extensions (5042 ms)                        984 B        1.25 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/database/functions (404 ms)                        4.54 kB        1.26 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/database/indexes (404 ms)                          23.9 kB        1.18 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/database/migrations (405 ms)                       6.34 kB        1.16 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/database/publications (404 ms)                     1.15 kB        1.25 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/database/replication (643 ms)                      18.7 kB        1.21 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/database/roles (404 ms)                              601 B        1.25 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/database/schemas (643 ms)                          10.1 kB        1.22 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/database/tables (784 ms)                           3.68 kB        1.34 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/database/tables/[id] (786 ms)                      3.83 kB        1.34 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/database/triggers (487 ms)                         31.9 kB        1.19 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/database/types (487 ms)                              625 B        1.25 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/editor (786 ms)                                    3.42 kB        1.38 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/editor/[id] (394 ms)                               10.1 kB        1.38 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/editor/new (784 ms)                                3.28 kB        1.38 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/functions (449 ms)                                 2.67 kB        1.17 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/functions/[functionSlug] (450 ms)                  12.6 kB        1.21 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/functions/[functionSlug]/code (436 ms)             6.72 kB         1.2 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/functions/[functionSlug]/details (490 ms)          6.55 kB         1.2 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/functions/[functionSlug]/invocations (1063 ms)      2.5 kB        1.25 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/functions/[functionSlug]/logs (1067 ms)            2.49 kB        1.25 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/functions/new (449 ms)                             4.27 kB        1.17 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/functions/secrets (450 ms)                         5.66 kB        1.17 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/integrations (449 ms)                              3.01 kB         1.2 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/integrations/[id] (449 ms)                           801 B         1.2 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/integrations/[id]/[pageId] (394 ms)                  806 B         1.2 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/integrations/[id]/[pageId]/[childId] (450 ms)        809 B         1.2 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/logs                                               81.1 kB        1.27 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/logs/auth-logs (1066 ms)                             972 B        1.22 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/logs/collections/[collectionToken] (394 ms)        5.35 kB        1.21 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/logs/cron-logs (1063 ms)                             892 B        1.22 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/logs/dedicated-pooler-logs                         1.05 kB        1.22 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/logs/edge-functions-logs (1066 ms)                   900 B        1.22 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/logs/edge-logs (1063 ms)                             888 B        1.22 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/logs/explorer                                      7.71 kB        1.21 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/logs/explorer/recent                               3.25 kB        1.18 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/logs/explorer/saved                                3.13 kB        1.18 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/logs/explorer/templates                            3.83 kB        1.18 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/logs/pg-upgrade-logs                                 860 B        1.22 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/logs/pgcron-logs                                     900 B        1.22 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/logs/pooler-logs                                     947 B        1.22 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/logs/postgres-logs                                   895 B        1.22 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/logs/postgrest-logs                                1.02 kB        1.22 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/logs/realtime-logs                                   879 B        1.22 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/logs/storage-logs                                    880 B        1.22 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/merge (392 ms)                                     16.3 kB        1.17 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/realtime/inspector                                 22.5 kB        1.21 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/realtime/policies (391 ms)                           21 kB        1.21 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/realtime/settings (391 ms)                         8.48 kB        1.16 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/reports                                            6.18 kB        1.17 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/reports/[id] (391 ms)                              35.2 kB        1.21 MB
#20 275.7 studio:build: ├   └ css/b4cedfbe320a7740.css                                        1.12 kB
#20 275.7 studio:build: ├ ○ /project/[ref]/reports/api-overview                               1.98 kB        1.19 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/reports/auth (396 ms)                               5.1 kB        1.22 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/reports/database (396 ms)                          19.8 kB        1.24 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/reports/edge-functions (396 ms)                     7.3 kB        1.21 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/reports/postgrest                                  4.43 kB        1.19 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/reports/realtime                                   6.41 kB        1.21 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/reports/storage                                     4.1 kB        1.19 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/settings (5063 ms)                                 2.43 kB        1.16 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/settings/addons                                    13.9 kB        1.17 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/settings/api                                       14.4 kB        1.17 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/settings/api-keys                                  4.82 kB        1.16 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/settings/api-keys/new                              12.8 kB        1.17 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/settings/auth                                      3.27 kB        1.16 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/settings/billing/usage                             2.57 kB        1.16 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/settings/compute-and-disk (5082 ms)                37.2 kB        1.19 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/settings/database (5078 ms)                        32.6 kB        1.21 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/settings/general (5079 ms)                         17.4 kB         1.2 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/settings/infrastructure (1139 ms)                   104 kB        1.32 MB
#20 275.7 studio:build: ├   └ css/fda52711ce1bc9f5.css                                         1.7 kB
#20 275.7 studio:build: ├ ○ /project/[ref]/settings/integrations (5077 ms)                     3.4 kB        1.18 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/settings/jwt (5077 ms)                             11.8 kB        1.19 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/settings/jwt/signing-keys (5077 ms)                16.6 kB        1.17 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/settings/log-drains (5077 ms)                        12 kB        1.17 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/settings/storage (855 ms)                           7.3 kB        1.22 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/sql (852 ms)                                       6.11 kB        1.21 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/sql/[id] (855 ms)                                  47.4 kB        1.28 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/sql/quickstarts (852 ms)                           4.97 kB        1.21 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/sql/templates (852 ms)                             4.99 kB        1.21 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/storage (849 ms)                                     459 B        1.24 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/storage/buckets                                    2.13 kB        1.25 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/storage/buckets/[bucketId] (849 ms)                9.38 kB        1.25 MB
#20 275.7 studio:build: ├ ○ /project/[ref]/storage/policies                                     510 B        1.24 MB
#20 275.7 studio:build: ├ ○ /reset-password                                                   6.56 kB         456 kB
#20 275.7 studio:build: ├ ○ /sign-in                                                          3.34 kB         457 kB
#20 275.7 studio:build: ├ ○ /sign-in-fly-tos                                                  1.59 kB         424 kB
#20 275.7 studio:build: ├ ○ /sign-in-mfa                                                      4.01 kB         458 kB
#20 275.7 studio:build: ├ ○ /sign-in-sso                                                      1.57 kB         456 kB
#20 275.7 studio:build: ├ ○ /sign-up (1067 ms)                                                4.26 kB         458 kB
#20 275.7 studio:build: └ ○ /support/new (1066 ms)                                            18.5 kB         815 kB
#20 275.7 studio:build: + First Load JS shared by all                                          491 kB
#20 275.7 studio:build:   ├ chunks/framework-966402f3242959c7.js                              66.2 kB
#20 275.7 studio:build:   ├ chunks/main-d717e217dcc8348c.js                                   39.4 kB
#20 275.7 studio:build:   ├ chunks/pages/_app-70edbeb15abd0a41.js                              312 kB
#20 275.7 studio:build:   ├ css/0e646312ef6c4769.css                                          69.2 kB
#20 275.7 studio:build:   └ other shared chunks (total)                                       4.47 kB
#20 275.7 studio:build: 
#20 275.7 studio:build: ƒ Middleware                                                          76.9 kB
#20 275.7 studio:build: 
#20 275.7 studio:build: ○  (Static)   prerendered as static content
#20 275.7 studio:build: ƒ  (Dynamic)  server-rendered on demand
#20 275.7 studio:build: 
#20 275.8 studio:build: sh: ./../../scripts/upload-static-assets.sh: not found
#20 275.8 studio:build:  ELIFECYCLE  Command failed.
#20 275.8 studio:build: ERROR: command finished with error: command (/app/apps/studio) /usr/local/bin/pnpm run build exited (1)
#20 275.9 studio#build: command (/app/apps/studio) /usr/local/bin/pnpm run build exited (1)
#20 275.9 
#20 275.9  Tasks:    0 successful, 1 total
#20 275.9 Cached:    0 cached, 1 total
#20 275.9   Time:    4m34.482s 
#20 275.9 Failed:    studio#build
#20 275.9 
#20 275.9  ERROR  run failed: command  exited (1)
#20 276.0  ELIFECYCLE  Command failed with exit code 1.
#20 ERROR: process "/bin/sh -c pnpm build:studio" did not complete successfully: exit code: 1
------
 > [base 11/11] RUN pnpm build:studio:
275.8 studio:build: ERROR: command finished with error: command (/app/apps/studio) /usr/local/bin/pnpm run build exited (1)
275.9 studio#build: command (/app/apps/studio) /usr/local/bin/pnpm run build exited (1)
275.9 
275.9  Tasks:    0 successful, 1 total
275.9 Cached:    0 cached, 1 total
275.9   Time:    4m34.482s 
275.9 Failed:    studio#build
275.9 
275.9  ERROR  run failed: command  exited (1)
276.0  ELIFECYCLE  Command failed with exit code 1.
------
Dockerfile:50
--------------------
  48 |     
  49 |     # Build only the studio app
  50 | >>> RUN pnpm build:studio
  51 |     
  52 |     # Production stage
--------------------
ERROR: failed to build: failed to solve: process "/bin/sh -c pnpm build:studio" did not complete successfully: exit code: 1
Error: buildx failed with: ERROR: failed to build: failed to solve: process "/bin/sh -c pnpm build:studio" did not complete successfully: exit code: 1
0s
0s
0s
Post job cleanup.
Removing temp folder /home/runner/work/_temp/docker-actions-toolkit-5sA32m
Post cache
  
1s
Post job cleanup.
/usr/bin/docker logout ghcr.io
Removing login credentials for ghcr.io
Post cache
  
13s
Post job cleanup.
Removing builder
  /usr/bin/docker buildx rm builder-28df2bc6-b156-4d00-96fc-920661691e2a
  builder-28df2bc6-b156-4d00-96fc-920661691e2a removed
Cleaning up certificates
Post cache
  
0s
Post job cleanup.
/usr/bin/git version
git version 2.50.1
Temporarily overriding HOME='/home/runner/work/_temp/a784493d-e121-4588-801c-ce7d5d391a23' before making global git config changes
Adding repository directory to the temporary git global config as a safe directory
/usr/bin/git config --global --add safe.directory /home/runner/work/ultrabase-max/ultrabase-max
/usr/bin/git config --local --name-only --get-regexp core\.sshCommand
/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'core\.sshCommand' && git config --local --unset-all 'core.sshCommand' || :"
/usr/bin/git config --local --name-only --get-regexp http\.https\:\/\/github\.com\/\.extraheader
http.https://github.com/.extraheader
/usr/bin/git config --local --unset-all http.https://github.com/.extraheader
/usr/bin/git submodule foreach --recursive sh -c "git config --local --name-only --get-regexp 'http\.https\:\/\/github\.com\/\.extraheader' && git config --local --unset-all 'http.https://github.com/.extraheader' || :"
