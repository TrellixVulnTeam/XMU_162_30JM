

set -ex



jupyter -h
jupyter-migrate -h
jupyter-troubleshoot --help
python -m pytest --pyargs jupyter_core -k "not test_not_on_path and not test_path_priority"
pip check
exit 0
