# uniprot-annotation

This is a bash script to annotate Accession IDs of BLAST-P output with taxonomy and GO. Protein-protein BLAST of sequences against the Uniprot database resulting in output file ( --outfmt 6) is taken as input and their annotation is printed to the file: "uniprot_annot.tsv"

Usage:
fetch_ids.sh [Blast-P output file]
