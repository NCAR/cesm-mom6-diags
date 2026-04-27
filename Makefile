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
	for file in `find . -name "*.ipynb"`; do echo $file ;  jupyter nbconvert --clear-output --inplace $file

clean:
	rm -rf native ncfiles notebooks PNG z *.o*
	git checkout notebooks
