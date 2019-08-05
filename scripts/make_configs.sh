#!/usr/bin/env bash

# Mostly stolen from https://github.com/cms-kr/TZWi
#       Matches NanoAODv5 recipes from https://twiki.cern.ch/twiki/bin/view/CMSPublic/WorkBookNanoAOD
## Check GT from the official twiki
##      https://twiki.cern.ch/twiki/bin/view/CMSPublic/SWGuideFrontierConditions
##      From PPD RunII Analysis Recipe (190131 updated, https://https://docs.google.com/presentation/d/1YTANRT_ZeL5VubnFq7lNGHKsiD7D3sDiOPNgXUYVI0I/edit#slide=id.g4dfd66f53d_1_7)

# OPTS_COMMON="-s NANO --no_exec --customise_commands=process.add_(cms.Service("\'"InitRootHandlers"\'",EnableIMT=cms.untracked.bool(False))) --nThreads 1"
OPTS_COMMON="-s NANO --no_exec --nThreads 1"
OPTS_MC="--mc --eventcontent NANOAODSIM --datatier NANOAODSIM"
OPTS_Data="--data --eventcontent NANOAOD --datatier NANOAOD"

CUSTOMBASE="Ntupler/NanoMaker/customize_cff"
CUSTOMIZE="--customise ${CUSTOMBASE}.customize_general,${CUSTOMBASE}.customize_dummy"

# # If you want to expand all the nanoaod configuration (including our own customizations)
# CUSTOMIZE="$CUSTOMIZE --inline_custom"

set -x

## 2016
ERA="Run2_2016,run2_nanoAOD_94X2016"
GT_MC="102X_mcRun2_asymptotic_v7"
GT_Data="102X_dataRun2_v11"
cmsDriver.py psets/pset_2016_Data $OPTS_COMMON $OPTS_Data --era $ERA --conditions $GT_Data $CUSTOMIZE
cmsDriver.py pset_2016_MC $OPTS_COMMON $OPTS_MC --era $ERA --conditions $GT_MC $CUSTOMIZE

## 2017
ERA="Run2_2017,run2_nanoAOD_94XMiniAODv2"
GT_MC="102X_mc2017_realistic_v7"
GT_Data="102X_dataRun2_v11"
cmsDriver.py pset_2017_Data $OPTS_COMMON $OPTS_Data --era $ERA --conditions $GT_Data $CUSTOMIZE
cmsDriver.py pset_2017_MC $OPTS_COMMON $OPTS_MC --era $ERA --conditions $GT_MC $CUSTOMIZE

## 2018
ERA="Run2_2018,run2_nanoAOD_102Xv1"
GT_MC="102X_upgrade2018_realistic_v12"
GT_Data="102X_dataRun2_v11" # 2018ABC
GT_DataPrompt="102X_dataRun2_Prompt_v14" # 2018D
cmsDriver.py pset_2018_DataPrompt $OPTS_COMMON $OPTS_Data --era $ERA --conditions $GT_DataPrompt $CUSTOMIZE
cmsDriver.py pset_2018_Data $OPTS_COMMON $OPTS_Data --era $ERA --conditions $GT_Data $CUSTOMIZE
cmsDriver.py pset_2018_MC $OPTS_COMMON $OPTS_MC --era $ERA --conditions $GT_MC $CUSTOMIZE

set +x
