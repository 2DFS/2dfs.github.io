---
title: Create and use your 2DFS Image Registry
date: 2017-01-05
draft: false
description: >
  Install the TDFS CLI builder and create your first 2DFS image. 
categories: [Getting Started]
tags: [getstarted, tdfs, 2dfs]
weight: 2
---

The 2DFS Image Registry is a container registry that supports `OCI` and `OCI+2DFS` images. 
It is built on top of the [OCI Distribution Specification](https://github.com/opencontainers/distribution-spec). 

### Deploy the 2DFS Image Registry as a container

Use Docker to deploy the 2DFS Image Registry as a container:

```bash
docker run -d -p 5000:5000 --restart=always --name 2dfs-registry ghcr.io/2dfs/2dfs-registry:edge
```

This will create the registry and expose it on port `5000`. 

For more details and configuration options, refer to the [2DFS Registry GitHub Repository](https://github.com/2DFS/2dfs-registry).

### Push your first 2DFS image to your registry 

Assuming the registry is running locally (address `0.0.0.0:5000`), let's build a simple 2DFS image and push it to your registry.
```bash
tdfs build ubuntu:22.04 0.0.0.0:5000/test/myfirsttdfs:v1
```
With this command, we created an image named `myfirsttdfs` belonging to the repository `test` of the registry `0.0.0.0:5000`, tagged with `v1`.

The output of `tdfs image ls` should look like this:
>```
> Url                               Tag    Type      Reference
>---------------------------------------------------------------------------------------------------------
> ...
> 12  0.0.0.0:5000/test/myfirsttdfs:v1  v1     OCI+2DFS  9e376e53b46e6c7ce79c3a8b5cd73382db345e3b410fce8ae62b2f3e54c7d149
>```

Now we can push the image to the registry:
```bash
tdfs push 0.0.0.0:5000/test/myfirsttdfs:v1
```
This command will push the `myfirsttdfs:v1` image to the `test` repository of the registry `0.0.0.0:5000`.