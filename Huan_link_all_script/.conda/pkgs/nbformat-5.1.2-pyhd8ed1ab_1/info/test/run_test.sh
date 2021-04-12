

set -ex



pip check
jupyter-trust -h
pytest -vv --pyargs nbformat --cov nbformat --no-cov-on-fail --cov-fail-under "70" -k "not (upgrade_v4_to_4_dot_5 or sample_notebook)"
exit 0
