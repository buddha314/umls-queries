setwd("/Users/buddha/github/buddha314/umls-queries/scripts/r")
library("igraph")
chrel <- "child_rels.txt"

# Your life will be easier if you thin down to just the pairs with a "child" relationship by doing
#
# > cat /Users/buddha/src/nih/umls/data/2015AA/META/MRREL.RRF | grep -i "chd" > child_rels.txt
#
# In the 2015 release, this should be  2,615,420 records. Doing "parent" gives you 3,103,796 records.

d <- read.table(chrel, sep="|")

# From this page: http://www.ncbi.nlm.nih.gov/books/NBK9685/table/ch03.T.related_concepts_file_mrrel_rrf/?report=objectonly
names(d) <- c("cui1", "aui1", "stype1", "rel", "cui2", "aui2", "stype2"
, "rela", "rui", "srui", "sab", "sl", "rg", "dir", "suppress", "cvf")

dim(d)

# iGraph wants the first two columns to be the nodes
e <- data.frame(d$cui1, d$cui2, d$rel)

# Now suppose you only want the relationships between the CUIs, I like to roll up over the AUIs.
f <- unique(e)

# Build the graph from f, which is only cui-cui
g <- graph.data.frame(d = f, directed=TRUE)

# Now you can do the fun stuff!
