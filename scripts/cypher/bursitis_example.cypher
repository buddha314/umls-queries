MATCH (a:Concept {cui:"C0263962"}), (c:Concept {cui:"C0029355"}),
 p=shortestPath((a)-[*..8]-(c))
WHERE ALL (n in nodes(p) WHERE "Concept" IN labels(n))
RETURN p;

MATCH (n)
WHERE n.cui IN ["C3887895","C0263962","C1136201","C0029355"]
RETURN n;

