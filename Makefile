# This process is done in three steps
# 1. Run the mom6-tools scripts with
#    $ make diags
# 2. Run the mom6-tools notebooks and jupyter-book with
#    $ make html
all: diags

diags:
	./run_scripts.sh
	echo "Remember to copy ncfiles/ to output dir!"

html:
	cd notebooks && qsub run_notebooks.sh

clean_notebooks:
	jupyter nbconvert --clear-output --inplace notebooks/*.ipynb

clean:
	rm -rf native ncfiles notebooks PNG z *.o*
	git checkout notebooks
