setwd("/Users/buddha/github/buddha314/umls-queries/scripts/r")
img <- "path_examples.Rdata"
library("igraph")
chrel <- "child_rels.txt"

# Your life will be easier if you thin down to just the pairs with a "child" relationship by doing
#
# > cat /Users/buddha/src/nih/umls/data/2015AA/META/MRREL.RRF | grep -i "chd" > child_rels.txt
#
# In the 2015 release, this should be  2,615,420 records. Doing "parent" gives you 3,103,796 records.
# Column names from this page: http://www.ncbi.nlm.nih.gov/books/NBK9685/table/ch03.T.related_concepts_file_mrrel_rrf/?report=objectonly
 
d <- read.table(chrel, sep="|")
names(d) <- c("cui1", "aui1", "stype1", "rel", "cui2", "aui2", "stype2"
, "rela", "rui", "srui", "sab", "sl", "rg", "dir", "suppress", "cvf")
dim(d)
# Now suppose you only want the relationships between the CUIs, I like to roll up over the AUIs.
f <- unique(data.frame(d$cui1, d$cui2, d$rel))
g <- graph.data.frame(d = f, directed=TRUE)
# Save some memory
rm(f)
save.image(img)


# Now, what you want, from this post: https://lists.nongnu.org/archive/html/igraph-help/2010-05/msg00093.html
leaves <- V(g)[degree(g, mode="out")==0]
roots <- V(g)[degree(g, mode="in")==0]

# iGraph likes the integer id of the node, rather than the CUI name.
root_ids <- which(V(g) %in% roots)
leaf_ids <- which(V(g) %in% leaves)

length(leaves)
length(roots)
save.image(img)

# What do you want to do next?

# Get all paths so you can take the max later.
p1 <- all_simple_paths(g, from=1, to=leaf_ids, mode=c("out"))

## Not run, this is where R barfs
Sys.time()
p1 <- all_simple_paths(g, from=root_ids, to=leaf_ids, mode=c("out"))
Sys.time()

