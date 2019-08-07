
## Installation

```
source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc6_amd64_gcc700
cmsrel CMSSW_10_2_15
cd $_/src/
cmsenv
git clone git@github.com:cmstas/NanoMaker.git Ntupler/NanoMaker
cd Ntupler/NanoMaker/
scram b -j8
cd test/
```


## Making psets
```
(cd psets ; ../../scripts/make_configs.sh)
```

