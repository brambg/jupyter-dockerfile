using HyperCollate

xml = """
<xml>Hoe zoet moet nochtans zijn dit <del>werven om</del><add>trachten naar</add> een vrouw,
de ongewisheid vóór de liefelijke toestemming!</xml>
"""

processed_xml = add_subst(xml)
show_svg(to_graph(processed_xml))
