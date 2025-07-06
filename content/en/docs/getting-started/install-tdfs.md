---
title: Build your first 2DFS image
date: 2025-07-01
draft: false
description: >
  Install the TDFS CLI builder and create your first 2DFS image. 
categories: [Getting Started]
tags: [getstarted, tdfs, 2dfs]
weight: 1
---

### `tdfs` Image Builder

`tdfs` is a command-line tool that allows you to create and manage 2DFS images. It is designed to be simple and easy to use. All you need to do is install the utility, create your `2dfs.json` descriptor file, and run the `tdfs build` command to create your first 2DFS image.

#### Installation
You can install the latest stable TDFS CLI builder using the following command:

```bash
curl -sfL 2dfs.github.io/install-tdfs.sh | sh -
```

### Your first 2DFS image
Create your first 2DFS image by creating a `2dfs.json` descriptor file in the current directory. 
For example, let's create two simple files and add them to the `2dfs.json` descriptor file:

Create two sample files in the current directory:

```bash
touch file1.txt file2.txt 
```

Now let's create a `2dfs.json` descriptor file with the following content:
```json
{
  "allotments":[
 {
      "src":"./file1.txt",
      "dst":"/file1.txt",
      "row":0,
      "col":0
 },
 {
      "src":"./file2.txt",
      "dst":"/file2.txt",
      "row":0,
      "col":1
 }
 ]
}
```
This descriptor creates two allotements, one for each file, and places them respectively in the first row, columns 0 and 1 of the `2dfs.field` layer. 

Once the `2dfs.json` descriptor file is created, you can run the `tdfs build` command to create your first 2DFS image. In this example, we'll start from a `ubuntu:22.04` base image:
```bash
tdfs build ubuntu:22.04 myfirsttdfs:v1
```
This command will build a `2dfs.field` layer on top of the `ubuntu:22.04` base image, *for each supported architecture* (amd64, arm64, etc.), and create a new 2DFS image named `myfirsttdfs:v1`. The `2dfs.field` layer will contain the two files you specified in the `2dfs.json` descriptor file.

{{< alert >}}
**Optimize your build for specific OS/Architecture combinations**

To build an image specific for an OS/Architecture combination, please use the `--platforms` flag. E.g., `tdfs build --platform linux/amd64,linux/arm64 ubuntu:22.04 myfirsttdfs:v1`
{{< /alert >}}

If the build is successful, you can now check the new 2DFS image by running the following command:
```bash
tdfs image ls
```

> The output should look like this:
>```
> Url                               Tag    Type      Reference
>---------------------------------------------------------------------------------------------------------
> 0  docker.io/library/ubuntu:22.04    22.04  OCI       12fac12bf3f369441a389d8947acc9c7a81bfd018e24aa8fedc0407845f59b87
> 1  docker.io/library/myfirsttdfs:v1  v1     OCI+2DFS  9e376e53b46e6c7ce79c3a8b5cd73382db345e3b410fce8ae62b2f3e54c7d149
>```

You should see both the base image and the new 2DFS image in the list, one with the `OCI` and the other with type `OCI+2DFS`.


{{< alert title="Note" >}}
Check all the available commands using `tdfs -h`
{{< /alert >}}

