---
title: Retrieve 2DFS Images from Docker
date: 2025-07-01
draft: false
description: >
  Use Docker to pull 2DFS images from an OCI+2DFS registry.
categories: [Getting Started]
tags: [getstarted, tdfs, 2dfs,docker]
weight: 3
---


{{< alert color="warning" >}}

When using a local registry, you need to configure Docker to trust the local *insecure* registry.
To do this, use the following configuration for your Docker daemon configuration file (usually located at `/etc/docker/daemon.json`):

```json
{
    "features": {
        "containerd-snapshotter": true
 },
    "insecure-registries": [
        "<your-registry-host>:5000"
 ]
}
```

Replace `<your-registry-host>` with the hostname or IP address of your registry.
{{< /alert >}}

To retrieve a 2DFS image from a Docker registry, you can use the `docker pull` command. This command allows you to download images from a registry that supports the OCI+2DFS format.

Additionally, you can use a semantic tag in the form `--<row from>.<col from>.<row to>.<col to>` to define the partition of the image you want to pull. 

Let's say we pushed to our registry an `OCI+2DFS` image with 2 rows and 2 columns, like this: 

| Row/Col | Col 0 | Col 1 |
|---------|-------|-------|
| **Row 0** | file1.txt| file2.txt |
| **Row 1** | file3.txt| file4.txt |


If we want to pull the first element of the first row (`file1.txt`), we can use the following command:
```bash
docker pull <your-registry-host>:5000/test/myfirsttdfs:v1--0.0.0.0
```

To retrieve the entire image as OCI image, you can use the following command:
```bash
docker pull <your-registry-host>:5000/test/myfirsttdfs:v1--0.0.1.1
```

To retrieve all elements except for `file3.txt`, you can use the following command:
```bash
docker pull <your-registry-host>:5000/test/myfirsttdfs:v1--0.0.0.1--1.0.1.1
```

{{< alert color="info" >}}
As you can see, semantic tags for partitions can be concatenated.

{{< /alert >}}