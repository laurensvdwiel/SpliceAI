# Dockerized SpliceAI

This repository provides a Docker containerized version of SpliceAI. By containerizing SpliceAI, users can easily deploy and run the tool without worrying about dependencies and environment configurations.

## Description

SpliceAI (Paper: [Jaganathan *et al*, Cell 2019](https://doi.org/10.1016/j.cell.2018.12.015), [GitHub/SpliceAI]([https://doi.org/10.1016/j.cell.2018.12.015](https://github.com/Illumina/SpliceAI))) is a deep learning-based tool designed to predict splice variants from genomic sequences. This containerization wraps around SpliceAI, making its deployment and execution more streamlined.

## Building the Container

To build the SpliceAI Docker image, use the following command:

```bash
docker build --pull --no-cache . -t spliceai:latest
```
This ensures that you pull the latest base image and do not use any cached layers, giving you the most recent version.

### Usage
Dockerized SpliceAI can be run from the command line:
```sh
docker run --rm -it -v $(pwd):/data/ --name spliceai_run spliceai:latest spliceai -I /data/input.vcf -O /data/output.vcf -R genome.fa -A grch37
```

Required parameters:
 - ```-v $(pwd):/data/``` mounts your current working directory to /data/ inside the container, allowing SpliceAI to access input files and write outputs directly to your host.
 - ```-I```: Input VCF with variants of interest.
 - ```-O```: Output VCF with SpliceAI predictions `ALLELE|SYMBOL|DS_AG|DS_AL|DS_DG|DS_DL|DP_AG|DP_AL|DP_DG|DP_DL` included in the INFO column (see table below for details). Only SNVs and simple INDELs (REF or ALT is a single base) within genes are annotated. Variants in multiple genes have separate predictions for each gene.
 - ```-R```: Reference genome fasta file. Can be downloaded from [GRCh37/hg19](http://hgdownload.cse.ucsc.edu/goldenPath/hg19/bigZips/hg19.fa.gz) or [GRCh38/hg38](http://hgdownload.cse.ucsc.edu/goldenPath/hg38/bigZips/hg38.fa.gz).
 - ```-A```: Gene annotation file. Can instead provide `grch37` or `grch38` to use GENCODE V24 canonical annotation files included with the package. To create custom gene annotation files, use `spliceai/annotations/grch37.txt` in repository as template.

Optional parameters:
 - ```-D```: Maximum distance between the variant and gained/lost splice site (default: 50).
 - ```-M```: Mask scores representing annotated acceptor/donor gain and unannotated acceptor/donor loss (default: 0).
