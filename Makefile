# This process is done in three steps
# 1. Run the mom6-tools scripts with
#    $ make diags
# 2. Run the mom6-tools notebooks and jupyter-book with
#    $ make html

all: diags

.PHONY: dwbc
dwbc:
	qsub scripts/dwbc.sh

.PHONY: climo_native
climo_native:
	qsub scripts/climo_native.sh

.PHONY: climo_z
climo_z:
	qsub scripts/climo_z.sh

.PHONY: basin_reductions
basin_reductions:
	qsub scripts/basin_reductions.sh

.PHONY: moc
moc:
	qsub scripts/moc.sh

.PHONY: moc_sigma2
moc_sigma2:
	qsub scripts/moc_sigma2.sh

.PHONY: pht
pht:
	qsub scripts/pht.sh

.PHONY: aaiw_pv
aaiw_pv:
	qsub scripts/aaiw_pv.sh

.PHONY: enso
enso:
	qsub scripts/enso.sh

.PHONY: transports
transports:
	qsub scripts/transports.sh

.PHONY: surface
surface:
	qsub scripts/surface.sh

.PHONY: equatorial
equatorial:
	qsub scripts/equatorial.sh

.PHONY: ts_levels
ts_levels:
	qsub scripts/ts_levels.sh

.PHONY: stats
stats:
	qsub scripts/stats.sh

.PHONY: drift_thetao
drift_thetao:
	qsub scripts/drift_thetao.sh

.PHONY: rms_thetao
rms_thetao:
	qsub scripts/rms_thetao.sh

.PHONY: drift_so
drift_so:
	qsub scripts/drift_so.sh

.PHONY: rms_so
rms_so:
	qsub scripts/rms_so.sh

.PHONY: tao
tao:
	qsub scripts/tao.sh


.PHONY: diags
diags: dwbc climo_native climo_z basin_reductions moc moc_sigma2 pht aaiw_pv \
       enso transports surface equatorial ts_levels stats drift_thetao \
       rms_thetao drift_so rms_so tao

.PHONY: html
html:
	cd notebooks && qsub run_notebooks.sh

.PHONY: clean_notebooks
clean_notebooks:
	jupyter nbconvert --clear-output --inplace notebooks/*.ipynb

.PHONY: clean
clean:
	rm -rf native ncfiles notebooks PNG z *.o*
	git checkout notebooks
