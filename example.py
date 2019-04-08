from collatex import *
from collatex.display_module import *

collation = Collation()
collation.add_plain_witness("A", "the cat is black")
collation.add_plain_witness("B", "black is the cat")
alignment_table = collate(collation)
print(alignment_table)

visualize_table_vertically_with_colors(alignment_table, collation)