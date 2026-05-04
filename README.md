# cesm-mom6-diags

Template scripts and Jupyter notebooks for running ocean diagnostics on CESM MOM6 simulations, including climatologies, transports, MOC, T/S biases, and more on NCAR systems.

Diagnostics are built on [mom6-tools](https://github.com/NCAR/mom6-tools). See the [mom6-tools documentation](https://mom6-tools.readthedocs.io/) for detailed guidance.

## Overview

The workflow has two steps:

1. **Run diagnostic scripts** (`make diags`) — submits PBS jobs to Casper that process model output into NetCDF files.
2. **Build HTML report** (`make html`) — runs Jupyter notebooks via [papermill](https://papermill.readthedocs.io/) and builds a [Jupyter Book](https://jupyterbook.org/) website, then deploys it to the CGD web server.

## Setup

### 1. Configure `diag_config.yml`

Edit `diag_config.yml` to point to your case. Key fields:

```yaml
Case:
  CASEROOT: /path/to/your/case/
  OCN_DIAG_ROOT: /path/to/output/ncfiles/
  SNAME: "my_case_short_name"

Avg:
  start_date: 'YYYY-01-01'
  end_date:   'YYYY-01-01'

oce_cat: /glade/work/chengz/ocean_catalogs/reference-datasets.yml
```

Note that `oce_cat` must be an absolute path.

The `Transports` section lists ocean sections where volume transports are computed. Edit or extend this list as needed.

### 2. Configure `~/.config/dask/ncar-jobqueue.yaml`

`moc.sh` requires large memory. To increase the memory requested, change the following lines in `~/.config/dask/ncar-jobqueue.yaml`:

```
memory: '16GiB' # Total amount of memory per job
resource-spec: select=1:ncpus=1:mem=16GB
```

### 3. Configure `notebooks/run_notebooks.sh`

Set the `CASE` and `COMPSET` variables at the top of `notebooks/run_notebooks.sh` to match your simulation:

```bash
CASE="your.case.name"
COMPSET=BLT1850   # BLT1850 or GIAF
```

Also update the PBS account (`#PBS -A`) in all `scripts/*.sh` files and in `notebooks/run_notebooks.sh` if needed.

### 4. Activate the conda environment

The scripts expect the `mom6-tools` conda environment:

```bash
conda activate mom6-tools
```

## Usage

### Step 1 — Run diagnostic scripts

```bash
make diags
```

This runs `run_scripts.sh`, which submits the following PBS jobs to Casper:

| Script | Description |
|---|---|
| `climo_native.sh` | Climatology on native MOM6 grid |
| `climo_z.sh` | Climatology on z-level grid |
| `basin_reductions.sh` | Basin-mean reductions |
| `moc.sh` | Meridional overturning circulation (z) |
| `moc_sigma2.sh` | MOC in sigma-2 density coordinates |
| `pht.sh` | Poleward heat transport |
| `aaiw_pv.sh` | AAIW potential vorticity |
| `enso.sh` | ENSO indices |
| `transports.sh` | Volume transports through key sections |
| `surface.sh` | Surface fields |
| `equatorial.sh` | Equatorial diagnostics |
| `ts_levels.sh` | T/S at depth levels |
| `stats.sh` | Global ocean statistics |
| `drift_thetao.sh` | Temperature drift |
| `rms_thetao.sh` | Temperature RMS error |
| `drift_so.sh` | Salinity drift |
| `rms_so.sh` | Salinity RMS error |
| `tao.sh` | TAO mooring diagnostics |

After jobs complete, copy the output NetCDF files to your `OCN_DIAG_ROOT`:

```bash
# Reminder also printed by make diags:
cp -r ncfiles/ $OCN_DIAG_ROOT
```

### Step 2 — Build HTML report

```bash
make html
```

This submits `notebooks/run_notebooks.sh` to Casper, which:
1. Generates the table of contents and intro page.
2. Executes all notebooks with [papermill](https://papermill.readthedocs.io/).
3. Builds a Jupyter Book from the notebooks.
4. Deploys the HTML output to `tungsten.cgd.ucar.edu` under `/project/diagnostics/external/<COMPSET>/<CASE>/ocn/`.

## Notebooks

| Notebook | Description |
|---|---|
| `ts_biases.ipynb` | Temperature and salinity biases |
| `moc.ipynb` | Meridional overturning circulation |
| `pht.ipynb` | Poleward heat transport |
| `mld.ipynb` | Mixed layer depth |
| `bld.ipynb` | Boundary layer depth |
| `transports.ipynb` | Volume transports |
| `equatorial.ipynb` | Equatorial sections |
| `ocean_stats.ipynb` | Global ocean statistics |
| `enso.ipynb` | ENSO |
| `aaiw_pv.ipynb` | AAIW potential vorticity |
| `ssh.ipynb` | Sea surface height |

## Utility targets

```bash
make clean_notebooks   # Clear all notebook outputs in place
make clean             # Remove all generated files and restore notebooks from git
```

## Dependencies

- [mom6-tools](https://github.com/NCAR/mom6-tools)
- [papermill](https://papermill.readthedocs.io/)
- [jupyter-book](https://jupyterbook.org/)
- [oce-catalogs](https://ncar.github.io/oce-catalogs/) — reference ocean observational datasets
- PBS/Casper (NCAR HPC)
