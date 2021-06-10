

set -ex



python -c 'from igraph.test import run_tests; run_tests()'
python test_cairo.py
python test_graphml.py
exit 0
