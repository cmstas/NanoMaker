
## Installation

```
source /cvmfs/cms.cern.ch/cmsset_default.sh
export SCRAM_ARCH=slc6_amd64_gcc700
cmsrel CMSSW_10_2_5
cd $_/src
cmsenv
git clone git@github.com:aminnj/NanoMaker.git Ntupler/NanoMaker
cd Ntupler/NanoMaker/test
scram b -j8
```


## Making psets
```
(cd psets ; ../scripts/make_configs.sh)
```

