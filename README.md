# SpliceAI
Containerized version of SpliceAI

## Example usage:


`docker run --rm -it -v $(pwd):/data/ --name spliceai_run spliceai:latest spliceai -I /data/input.vcf -A grch38 -O /data/spliceAI_output.vcf`
